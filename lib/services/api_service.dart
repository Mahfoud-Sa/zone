import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:zone_fe/models/response_model.dart';

const String _baseUrl = 'http://192.168.148.73:8000/api';

class ApiService {
  static String? token;
  Future<ResponseModel> get(String endPoint) async {
    try {
      final response = await http.get(_getUri(endPoint), headers: _headers());
      // print(response.statusCode);
      // print(response.body);
      return ResponseModel.fromJson(response);
    } on SocketException catch (_) {
      return ResponseModel(success: false, error: "فشل الوصول  للسيرفر");
    } catch (e) {
      return ResponseModel(success: false, error: "$e");
    }
  }

  Future<ResponseModel> post(String endPoint,
      {Map<String, dynamic>? body}) async {
    try {
      // print(_getUri(endPoint));
      final response = await http.post(_getUri(endPoint),
          headers: _headers(), body: json.encode(body));
      // print(response.statusCode);
      print(response.body);
      return ResponseModel.fromJson(response);
    } on SocketException catch (_) {
      return ResponseModel(success: false, error: "فشل الوصول  للسيرفر");
    } catch (e) {
      return ResponseModel(success: false, error: "$e");
    }
  }

  Future<ResponseModel> put(String endPoint,
      {Map<String, dynamic>? body}) async {
    try {
      final response = await http.put(_getUri(endPoint),
          headers: _headers(), body: json.encode(body));
      return ResponseModel.fromJson(response);
    } on SocketException catch (_) {
      return ResponseModel(success: false, error: "فشل الوصول ب السيرفر");
    } catch (e) {
      return ResponseModel(success: false, error: "$e");
    }
  }

  Map<String, String> _headers() {
    return {
      "Content-type": "Application/json",
      "Accept": "Application/json",
      if (token != null) "Authorization": "Bearer ${token!}"
    };
  }

  Uri _getUri(String endPoint) {
    return Uri.parse('$_baseUrl/$endPoint');
  }
}
