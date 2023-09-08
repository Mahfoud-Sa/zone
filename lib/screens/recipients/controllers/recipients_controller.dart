import 'package:get/get.dart';
import 'package:zone_fe/main.dart';
import 'package:zone_fe/services/local_services/init_database.dart';

import '../models/recipience_model.dart';

class RecipientsController {
  Future<List<RecipientModel>> getRecipients(int id) async {
    final recipients = await db.query(
      DBHelper.recipientsTable,
      where: 'listId = ?',
      whereArgs: [id],
    );
    return recipients.map((e) => RecipientModel.fromJson(e, id)).toList();
  }

  static Future<int> updateState(RecipientModel recipient) async {
    var rec = RecipientModel.toJson(recipient.listId!, recipient);
    rec['isReceive'] = 1;
    int count = await db.update(
      DBHelper.recipientsTable,
      rec,
      where: 'listId = ? AND barcode = ?',
      whereArgs: [recipient.listId, recipient.barcode],
    );
    if (count > 0) {
      List lists = await db.query(
        DBHelper.recipientsTable,
        columns: ['isReceive'],
        where: 'listId = ?',
        whereArgs: [recipient.listId],
      );
      bool notCompleted = lists.any((element) => element['isReceive'] == 0);
      if (notCompleted) {
        return 1;
      } else {
        await db.rawUpdate('UPDATE ${DBHelper.listTable} SET state = ? WHERE id = ?', [1, recipient.listId]);
        return 2;
      }
    }
    return 0;
  }
}
