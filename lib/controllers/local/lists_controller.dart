import 'package:zone_fe/screens/home/models/list_model.dart';
import 'package:zone_fe/screens/recipients/models/recipience_model.dart';
import 'package:zone_fe/services/local_services/init_database.dart';

import '../../main.dart';
import '../../models/point_model.dart';

class ListsController {
  static Future<List<ListModel>> getLists(int idPoint) async {
    final lists = await db.query(DBHelper.listTable,where: 'idPoint = ?',whereArgs: [idPoint]);
    return lists.map((e) => ListModel.fromJson(e)).toList();
  }

  static Future<void> addLists(List<ListModel> lists) async {
    await db.transaction((txn) async {
      final batch = txn.batch();
      for (var l in lists) {
        int id = await txn.insert(DBHelper.listTable, ListModel.toJson(l));
        for (var r in l.recipients!) {
          batch.insert(DBHelper.recipientsTable, RecipientModel.toJson(id, r));
        }
      }
      await batch.commit(noResult: true);
    });
  }

  static Future<void> setStateComplete(ListModel list,int indexPoint) async {
    await db.update(
      DBHelper.listTable,
      ListModel.toJson(list),
      where: 'id = ?',
      whereArgs: [list.id],
    );
  }
}
