import 'package:get/get.dart';

class RecipientModel {
  // final int id;
  final String name;
  final String barcode;
  final int familyCount;
  final String birthday;
  final String workFor;
  final int cardNumber;
  final String? socialState;
  final String residentType;
  final int recordId; //from the server
  final int? listId; //the id from list
  final RxBool isReceive;
  final String image;
  final int phoneNum;

  RecipientModel({
    // required this.id,
    required this.name,
    required this.barcode,
    required this.familyCount,
    required this.birthday,
    required this.workFor,
    required this.cardNumber,
    required this.socialState,
    required this.residentType,
    required this.recordId,
    this.listId,
    required this.isReceive,
    required this.image,
    required this.phoneNum
  });

  static Map<String, dynamic> toJson(int listId, RecipientModel recipient) {
    return <String, dynamic>{
      // 'id': recipient.id,
      'recipientName': recipient.name,
      'barcode': recipient.barcode,
      'familyCount': recipient.familyCount,
      'birthday': recipient.birthday,
      'workFor': recipient.workFor,
      'passportNum': recipient.cardNumber,
      'socialState': recipient.socialState ?? '',
      'residentType': recipient.residentType,
      'recordID': recipient.recordId,
      'listId': listId,
      'image':recipient.image,
      'phoneNum':recipient.phoneNum,
      'isReceive': 0
    };
  }

  factory RecipientModel.fromJson(Map<String, dynamic> map, [int? listId]) {
    return RecipientModel(
        // id: map['id'] as int,
        name: map['recipientName'] as String,
        barcode: map['barcode'] as String,
        familyCount: map['familyCount'] as int,
        birthday: map['birthday'] as String,
        workFor: map['workFor'] as String,
        cardNumber: map['passportNum'] as int,
        socialState: map['socialState'] as String?,
        residentType: map['residentType'] as String,
        recordId: map['recordID'] as int,
        image: map['image'],
        phoneNum:map['phoneNum'] as int,
        listId: listId,
        isReceive: map['isReceive'] != null
            ? RxBool(map['isReceive'] == 1)
            : RxBool(false));
  }
}
