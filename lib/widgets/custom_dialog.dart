import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zone_fe/screens/recipients/controllers/recipients_controller.dart';
import 'package:zone_fe/screens/recipients/models/recipience_model.dart';

class MyDialog {
  opendilog(BuildContext context, String title, String content) {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    content,
                    style: const TextStyle(fontFamily: "Myfont"),
                  )
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  child: const Text("حسنا"))
            ],
          );
        });
  }

  Future<int?> EnterBarCode(
      BuildContext context, RecipientModel recipient) async {
    return await showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("تأكيد عملية الاستلام"),
            content: SizedBox(
                height: 150,
                child: Column(
                  children: [
                    Text(
                      recipient.name,
                      style: const TextStyle(
                        fontFamily: "Myfont",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent),
                            onPressed: () async {
                              print("test");
                              int updated =
                                  await RecipientsController.updateState(
                                      recipient);
                              if (updated != 0) {
                                Navigator.of(context).pop(updated);
                              }
                            },
                            child: const Text("تأكيد")),
                      ],
                    ))
                  ],
                )),
          );
        });
  }

  viweBarcode(BuildContext context, String barcode) {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("باركود"),
              content: SingleChildScrollView(
                child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: barcode,
                  width: 200,
                  height: 200,
                ),
              ));
        });
  }
}
