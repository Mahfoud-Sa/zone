import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zone_fe/main.dart';
import 'package:zone_fe/models/point_model.dart';
import 'package:zone_fe/services/fake_api.dart';
import 'package:zone_fe/services/local_services/init_database.dart';

import '../../../controllers/local/points_controller.dart';
import '../../../models/user_model.dart';
import '../../../services/api_service.dart';
import '../../../widgets/my_drawer.dart';

class LoginController extends GetxController {
  final ApiService _api = ApiService();
  bool isLoading = false;
  String? error;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    isLoading = true;
    update();
    error = null;
    var response = await _api.post(
      "login",
      body: {"email": username, "password": password},
    );
    if (response.success) {
      db = await DBHelper().database;
      MyDrawer.user = UserModel.fromApiJson(response.data['user']);
      MyDrawer.points = PointModel.fromApiJson(response.data['user']['DistributionPoint']);
      ApiService.token = response.data['Access Token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", UserModel.toJsonString(MyDrawer.user));
      await PointsController.addPoints(MyDrawer.points);
      await prefs.setString("token", ApiService.token!);
    } else {
      error = response.error;
       print(response.error);
    }
    isLoading = false;
    update();
  }
}
