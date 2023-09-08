import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zone_fe/models/point_model.dart';
import 'package:zone_fe/services/api_service.dart';
import 'package:zone_fe/services/local_services/init_database.dart';
import '../models/user_model.dart';

class MyDrawer extends StatelessWidget {
  static late UserModel user;
  static late List<PointModel> points;
  static RxInt selectedIndex = RxInt(0);
  // final ApiService _api = ApiService();
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(user.image),
            ),
          ),
          Expanded(
            child: Obx(() {
              return Column(
                children: [
                  const Text(
                    "نقاط التوزيع",
                    style: TextStyle(
                      fontFamily: "Myfont",
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () async {
                  //     // var response = await _api.get("refreshPoints");
                  //     // print(response.data);
                  //   },
                  //   icon: const Icon(Icons.refresh),
                  // ),
                  ListView(
                    shrinkWrap: true,
                    // physics: ScrollPhysics(parent: ),
                    children: [
                      for (int i = 0; i < points.length; i++)
                        Card(
                          color: selectedIndex.value == i
                              ? Colors.orangeAccent
                              : null,
                          child: ListTile(
                            title: Text(points[i].name),
                            trailing: points[i].isListDownloaded.value
                                ? const Icon(
                                    Icons.offline_pin,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.block,
                                    color: Colors.red,
                                  ),
                            onTap: () {
                              Navigator.of(context).pop();
                              selectedIndex(i);
                            },
                          ),
                        )
                    ],
                  ),
                ],
              );
            }),
          ),
          const Divider(thickness: 0.5),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              "تسجيل الخروج",
              style: TextStyle(fontFamily: "Myfont"),
            ),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              DBHelper db = DBHelper();
              db.resetDatabase();
              selectedIndex = RxInt(0);
              Navigator.pushReplacementNamed(context, "/login");
            },
          )
        ],
      ),
    );
  }
}
