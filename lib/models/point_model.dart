// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class PointModel {
  final int id;
  final String name;
  RxBool isListDownloaded;
  PointModel({
    required this.id,
    required this.name,
    required this.isListDownloaded,
  });

  static List<PointModel> fromApiJson(List points) {
    return points
        .map((map) => PointModel(
            id: map['id'] as int,
            name: map['name'] as String,
            isListDownloaded: RxBool(false)))
        .toList();
  }

  static List<PointModel> fromLocalJson(List points) {
    return points
        .map(
          (map) => PointModel(
              id: map['id'] as int,
              name: map['name'] as String,
              isListDownloaded: (map['isListDownloaded'] as int) == 1
                  ? RxBool(true)
                  : RxBool(false)),
        )
        .toList();
  }

  static Map<String, dynamic> toJson(PointModel point) {
    return {
      'id': point.id,
      'name': point.name,
      'isListDownloaded': point.isListDownloaded.value ? 1 : 0,
    };
  }
}
