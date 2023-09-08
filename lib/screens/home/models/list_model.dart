import 'package:get/get.dart';
import 'package:zone_fe/widgets/my_drawer.dart';

import '../../recipients/models/recipience_model.dart';

class ListModel {
  final int id;
  final String name;
  final String createDate;
  final RxString state;
  final String note;
  // final int? idPoint;
  final List<RecipientModel>? recipients;
  ListModel({
    required this.id,
    required this.name,
    required this.createDate,
    required this.state,
    required this.note,
    //  this.idPoint,
    this.recipients,
  });

  static Map<String, dynamic> toJson(ListModel list ) {
    int indexPoint=MyDrawer.selectedIndex.value;
    return <String, dynamic>{
      'id': list.id,
      'name': list.name,
      'creationDate': list.createDate,
      'state': list.state.value,
      'note': list.note,
      'idPoint':MyDrawer.points[indexPoint].id
    };
  }

  factory ListModel.fromJson(Map<String, dynamic> map) {
    return ListModel(
      id: map['id'] as int,
      name: map['name'] as String,
      createDate: map['creationDate'] as String,
      state: RxString(map['state'] as String),
      note: map['note'] as String,
      recipients: map['Records'] != null
          ? (map['Records'] as List)
              .map((e) => RecipientModel.fromJson(e))
              .toList()
          : null,
    );
  }
}
