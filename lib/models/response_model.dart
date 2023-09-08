import 'dart:convert';

import 'package:http/http.dart';

class ResponseModel {
  final bool success;
  final dynamic data;
  final String? error;
  ResponseModel({
    required this.success,
    this.data,
    this.error,
  });
  static ResponseModel fromJson(Response response) {
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return ResponseModel(success: true, data: body);
    } else {
      return ResponseModel(success: false, error: "حصل خطأ");
    }
  }
}
