// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zone_fe/screens/home/controllers/home_controller.dart';
import 'package:zone_fe/screens/home/views/home_search.dart';
import 'package:zone_fe/screens/home/models/list_model.dart';
import 'package:zone_fe/screens/recipients/views/recipients_screen.dart';
import 'package:zone_fe/widgets/custom_dialog.dart';

import '../../../widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ListModel>> getRecipientList;
  final HomeController controller = HomeController();
  MyDialog dialog = MyDialog();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('قوائم الاستلام'),
          actions: [
            IconButton(
              onPressed: () async {
                try {
                  await controller.refresh(MyDrawer.selectedIndex.value);
                  setState(() {});
                } catch (e) {
                  dialog.opendilog(context, "خطأ", e.toString());
                }
              },
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchList(listdata: HomeController.lists));
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: Obx(() {
          final index = MyDrawer.selectedIndex.value;
          var recipientList = controller.getRecipientList(index);
          try {
            var recipientList = controller.getRecipientList(index);
            return FutureBuilder(
              future: recipientList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  HomeController.lists = snapshot.data!;
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: HomeController.lists.length,
                      itemBuilder: (cxt, index) {
                        final item = HomeController.lists[index];
                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            Card(
                              elevation: 5,
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                child: ListTile(
                                  leading: IconButton(
                                    onPressed: () async {
                                      int upload_State =
                                          await HomeController().upload(index);
                                      if (upload_State == 1) {
                                        dialog.opendilog(
                                            context, "تنبيه", "تم الرفع بنجاح");
                                      } else if (upload_State == 0) {
                                        dialog.opendilog(context, "تنبيه",
                                            "مشكلة في الارسال");
                                      } else {
                                        dialog.opendilog(context,
                                            "لايمكن الرفع", "لم يستلم احد بعد");
                                      }
                                    },
                                    icon: const Icon(Icons.upload_file_rounded),
                                  ),
                                  title: Text(
                                    item.name,
                                    style:
                                        const TextStyle(fontFamily: "Myfont"),
                                  ),
                                  subtitle: Obx(() {
                                    if (item.state.value == '0') {
                                      return const Text(
                                        "غير مكتملة",
                                        style: TextStyle(
                                            fontFamily: "Myfont",
                                            color: Colors.redAccent),
                                      );
                                    } else {
                                      return const Text(
                                        "مكتملة",
                                        style: TextStyle(
                                            fontFamily: "Myfont",
                                            color: Colors.greenAccent),
                                      );
                                    }
                                  }),
                                  trailing: Column(children: [
                                    Expanded(
                                        child: Text(
                                      item.createDate,
                                      style: const TextStyle(
                                          fontFamily: "Myfont",
                                          color: Colors.black),
                                    )),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          dialog.opendilog(
                                              context, "ملاحظات", item.note);
                                        },
                                        icon:
                                            const Icon(Icons.note_alt_outlined),
                                        iconSize: 25,
                                      ),
                                    )
                                  ]),
                                  onTap: (() {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecipientsScreen(index)));
                                    // context
                                    //     .read<PersonalInListData>()
                                    //     .getRecipient(item['id']);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (ctx) => PesonalList()));
                                  }),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('لا توجد قوائم'),
                    );
                  }
                } else {
                  return Center(
                    child: TextButton(
                      child: Text('${snapshot.error}'),
                      onPressed: () {},
                    ),
                  );
                }
              },
            );
          } catch (e) {
            return Text(e.toString());
          }
        }));
  }
}
