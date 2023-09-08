import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:zone_fe/screens/personal_info/view/personal_info_screen.dart';
import 'package:zone_fe/screens/recipients/models/recipience_model.dart';
import 'package:zone_fe/screens/recipients/views/recipients_search.dart';
import 'package:zone_fe/widgets/custom_dialog.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/recipients_controller.dart';

class RecipientsScreen extends StatefulWidget {
  final int index;
  const RecipientsScreen(this.index, {super.key});

  @override
  State<RecipientsScreen> createState() => _RecipientsScreenState();
}

class _RecipientsScreenState extends State<RecipientsScreen> {
  final controller = RecipientsController();
  late Future<List<RecipientModel>> getRecipients;
  late final int listId;
  List<RecipientModel> recipients = [];
  @override
  void initState() {
    listId = HomeController.lists[widget.index].id;
    getRecipients = controller.getRecipients(listId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المستلمين'),
        actions: [
          IconButton(
            onPressed: () async {
              if (recipients.isNotEmpty) {
                var barcode = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));

                if (barcode is String) {
                  int? ind;
                  for (int i = 0; i < recipients.length; i++) {
                    if (recipients[i].barcode == barcode) {
                      ind = i;
                      break;
                    }
                  }
                  if (ind != null) {
                    MyDialog()
                        .EnterBarCode(context, recipients[ind])
                        .then((value) {
                      if (value != null) {
                        recipients[ind!].isReceive.value = true;
                        if (value == 2) {
                          HomeController.lists[widget.index].state.value = "1";
                        }
                      }
                    });
                  }else{
                    MyDialog().opendilog(context, "تنبيه", "المستلم غير موجود");
                  }
                }
              }
            },
            icon: const Icon(Icons.qr_code_scanner_rounded),
          ),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchRecipient(recipients: recipients,indexList: widget.index));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getRecipients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            recipients = snapshot.data!;
            if (recipients.isNotEmpty) {
              return ListView.builder(
                physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                shrinkWrap: true,
                itemCount: recipients.length,
                itemBuilder: (cxt, index) {
                  final item = recipients[index];
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
                                        recipients[index].isReceive.value =
                                            true;
                                        if (value == 2) {
                                          HomeController.lists[widget.index]
                                              .state.value = "1";
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
                                      builder: (context) =>
                                          PersonalInfo(item)));
                                }),
                              ),
                            )),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text('لا يوجد مستلمين'));
            }
          } else {
            return Center(
              child: TextButton(
                child: Text('${snapshot.error}'),
                onPressed: () {
                  setState(() {
                    getRecipients = controller.getRecipients(listId);
                  });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
