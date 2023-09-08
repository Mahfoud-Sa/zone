import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zone_fe/controllers/local/points_controller.dart';
import 'package:zone_fe/main.dart';
import 'package:zone_fe/services/local_services/init_database.dart';

import 'models/user_model.dart';
import 'services/api_service.dart';
import 'widgets/my_drawer.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    startUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> startUp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    db = await DBHelper().database;
    if (token != null) {
      ApiService.token = token;
      MyDrawer.user = UserModel.fromStringJson(pref.getString("user")!);
      MyDrawer.points = await PointsController.getPoints();
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      Navigator.of(context).pushReplacementNamed("/login");
    }
  }
}
