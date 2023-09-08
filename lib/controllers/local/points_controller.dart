import 'package:zone_fe/services/local_services/init_database.dart';

import '../../main.dart';
import '../../models/point_model.dart';

class PointsController {
  static Future<List<PointModel>> getPoints() async {
    final points = await db.query(DBHelper.pointTable);
    return PointModel.fromLocalJson(points);
  }

  static Future<void> addPoints(List<PointModel> points) async {
    final batch = db.batch();
    for (var p in points) {
      batch.insert(DBHelper.pointTable, PointModel.toJson(p));
    }
    await batch.commit(noResult: true);
  }

  static Future<void> setPointDownloaded(PointModel point) async {
    await db.update(
      DBHelper.pointTable,
      PointModel.toJson(point),
      where: 'id = ?',
      whereArgs: [point.id],
    );
  }
}
