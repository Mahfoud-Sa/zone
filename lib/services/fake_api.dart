import 'package:flutter/services.dart';
import 'package:http/http.dart';

import '../models/response_model.dart';

class FakeApi {
  Future<ResponseModel> post(endpoint, {Map<String, dynamic>? body}) async {
    final rawData = await rootBundle.loadString("assets/fake_api/$endpoint.json");
    final Response response = Response(rawData, 200);
    return ResponseModel.fromJson(response);
  }

  Future<ResponseModel> get(endpoint, {Map<String, dynamic>? body}) async {
    final rawData = await rootBundle.loadString("assets/fake_api/$endpoint.json");
    final Response response = Response(rawData, 200);
    return ResponseModel.fromJson(response);
  }
}
