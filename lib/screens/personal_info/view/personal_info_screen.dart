import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zone_fe/screens/personal_info/widgets/info_row.dart';
import 'package:zone_fe/screens/recipients/models/recipience_model.dart';
import 'package:zone_fe/widgets/custom_dialog.dart';

class PersonalInfo extends StatelessWidget {
  final RecipientModel recipient;

  const PersonalInfo(this.recipient, {super.key});
  @override
  Widget build(BuildContext context) {
    MyDialog dialog = MyDialog();
    return Scaffold(
        appBar: AppBar(
          title: Text('التفاصيل الشخصيه'),
          actions: [
            IconButton(
              onPressed: () {
                dialog.viweBarcode(context, recipient.barcode);
              },
              icon: const Icon(
                Icons.qr_code_2_outlined,
              ),
              iconSize: 40,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                    maxRadius: 90,
                    backgroundImage:
                        MemoryImage(base64Decode(recipient.image))),
                // InfoRow(
                //     icon: Icons.numbers,
                //     label: 'الرقم التسلسلي',
                //     value: recipient.id.toString()),
                InfoRow(
                    icon: Icons.person_outline_outlined,
                    label: 'الاسم :',
                    value: recipient.name.toString()),
                InfoRow(
                    icon: Icons.phone,
                    label: 'الهاتف :',
                    value: recipient.phoneNum.toString()),
                InfoRow(
                    icon: Icons.badge,
                    label: 'رقم البطاقة  :',
                    value: recipient.cardNumber.toString()),
                InfoRow(
                    icon: Icons.qr_code_2_rounded,
                    label: 'رقم الباركود  :',
                    value: recipient.barcode.toString()),
                InfoRow(
                    icon: Icons.family_restroom_rounded,
                    label: ' عدد افراد الاسره :',
                    value: recipient.familyCount.toString()),
                InfoRow(
                    icon: Icons.home,
                    label: 'نوع السكن :',
                    value: recipient.residentType.toString()),
                InfoRow(
                    icon: Icons.person_pin_outlined,
                    label: ' الحالة الاجتماعية :',
                    value: recipient.socialState.toString()),
                InfoRow(
                    icon: Icons.work_outline_rounded,
                    label: ' الوظيفة  :',
                    value: recipient.workFor.toString()),
                InfoRow(
                    icon: Icons.calendar_month_outlined,
                    label: ' تاريخ الميلاد  :',
                    value: recipient.birthday.toString()),
              ],
            ),
          ),
        ));
  }
}
