import 'package:zone_fe/controllers/local/lists_controller.dart';
import 'package:zone_fe/main.dart';
import 'package:zone_fe/screens/home/models/list_model.dart';
import 'package:zone_fe/services/api_service.dart';
import 'package:zone_fe/services/fake_api.dart';

import '../../../controllers/local/points_controller.dart';
import '../../../services/local_services/init_database.dart';
import '../../../widgets/my_drawer.dart';

class HomeController {
  final ApiService _api = ApiService();
  static List<ListModel> lists = [];
  Future<List<ListModel>> getRecipientList(int index) async {
    lists.clear();
    int pointId = MyDrawer.points[index].id;
    bool isDownloaded = MyDrawer.points[index].isListDownloaded.value;
    late final recipientsList;
    if (isDownloaded) {
      recipientsList = ListsController.getLists(pointId);
      return recipientsList;
    } else {
      final res = await _api.get('download/$pointId');
      if (res.success) {
        recipientsList = (res.data['data'] as List)
            .map((e) => ListModel.fromJson(e))
            .toList();

        await ListsController.addLists(recipientsList);

        MyDrawer.points[index].isListDownloaded(true);

        await PointsController.setPointDownloaded(MyDrawer.points[index]);
        return recipientsList;
      } else {
        
        var x=res.error;
        throw res.error!;
        
      }
    }
  }

  Future<int> upload(int index) async {
    final recipients = await db.query(
      DBHelper.recipientsTable,
      columns: ['recordID AS id'],
      where: 'listId = ? AND isReceive = ?',
      whereArgs: [lists[index].id, 1],
    );
    if (recipients.isNotEmpty) {
      final resopnse = await _api.post("upload",
          body: {"recipientListID": lists[index].id, "MyRecords": recipients});
      return resopnse.success ? 1 : 0;
    }
    return 2;
  }

  Future<void> refresh(int index) async {
    final listId = await db.query(
      DBHelper.listTable,
      columns: ['id'],
    );
    print(listId);
    int pointId = MyDrawer.points[index].id;

    late List<ListModel> recipientsList;

    final res = await _api.get('download/$pointId');

    if (res.success) {
      recipientsList =
          (res.data['data'] as List).map((e) => ListModel.fromJson(e)).toList();
      for (int i = 0; i < recipientsList.length; i++) {
        if (!listId.any((map) => map.containsValue(recipientsList[i].id))) {
          await ListsController.addLists([recipientsList[i]]);
        }
      }
    } else {
      throw res.error!;
    }

    // MyDrawer.points[index].isListDownloaded(true);

    // await PointsController.setPointDownloaded(MyDrawer.points[index]);
  }
}
