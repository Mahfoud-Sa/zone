import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zone_fe/screens/home/controllers/home_controller.dart';
import 'package:zone_fe/screens/personal_info/view/personal_info_screen.dart';
import 'package:zone_fe/screens/recipients/models/recipience_model.dart';
import 'package:zone_fe/widgets/custom_dialog.dart';

class SearchRecipient extends SearchDelegate {
  final List<RecipientModel> recipients;
  final int indexList;
  SearchRecipient({required this.recipients, required this.indexList});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return body(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final recipients = context.watch<PersonalInListData>().recipientsApi;
    return body(context);
  }

  Widget body(context) {
    List fillter = recipients
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return recipients.isEmpty
        ? const Center(
            child: Text("لايوجد مستلمين",
                style: TextStyle(fontFamily: "Myfont", fontSize: 30)))
        : ListView.builder(
            physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
            shrinkWrap: true,
            itemCount: query == "" ? recipients.length : fillter.length,
            itemBuilder: (cxt, index) {
              final item = query == "" ? recipients[index] : fillter[index];
              // print(item);
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Obx(
                          () => ListTile(
                            leading: IconButton(
                              onPressed: () {
                                MyDialog()
                                    .EnterBarCode(context, item)
                                    .then((value) {
                                  if (value != null) {
                                    recipients[index].isReceive.value = true;
                                    if (value == 2) {
                                      HomeController
                                          .lists[indexList].state.value = "1";
                                    }
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.check_circle_rounded,
                                color: item.isReceive.value
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                              ),
                            ),
                            title: Text(
                              item.name,
                              style: const TextStyle(fontFamily: "Myfont"),
                            ),
                            trailing: Text(
                              item.isReceive.value ? "استلم" : "لم يستلم",
                              style: TextStyle(
                                  fontFamily: "Myfont",
                                  color: item.isReceive.value
                                      ? Colors.greenAccent
                                      : Colors.redAccent),
                            ),
                            onTap: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PersonalInfo(item)));
                            }),
                          ),
                        )),
                  ),
                ],
              );
            },
          );
  }
}
