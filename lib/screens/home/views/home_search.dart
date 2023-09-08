import 'package:flutter/material.dart';
import 'package:zone_fe/screens/home/models/list_model.dart';
import 'package:zone_fe/screens/recipients/views/recipients_screen.dart';
import 'package:zone_fe/widgets/custom_dialog.dart';



class SearchList extends SearchDelegate {
   MyDialog dialog = MyDialog();
   late List<ListModel> fillter;
 final List<ListModel> listdata;
 SearchList({required this.listdata});
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

     return body(context) ;
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return  body(context);
  }
  Widget body(context){
    fillter = listdata
        .where((element) => element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
   return listdata.isEmpty
        ? const Center(
            child: Text("لاتوجد قوائم",
                style: TextStyle(fontFamily: "Myfont", fontSize: 30)))
        : ListView.builder(
            itemCount: query == "" ? listdata.length : fillter.length,
            itemBuilder: (cxt, index) {
              final item = query == "" ? listdata[index] : fillter[index];
              return  Column(
                      children: [
                        const SizedBox(height: 10),
                        Card(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: ListTile(
                              leading: IconButton(
                                onPressed: () async {
                                  // print(distrbuter_id);
                                  // bool isUpdated = await context
                                  //     .read<LoginData>()
                                  //     .updateListState(
                                  //         distrbuter_id, item['id']);
                                  // isUpdated
                                  //     ? dialog.opendilog(context, "تنبية",
                                  //         "تم رفع القائمة بنجاح")
                                  //     : dialog.opendilog(context, "تنبية",
                                  //         "يرجى اكمال عملية التسليم");
                                },
                                icon: const Icon(Icons.upload_file_rounded),
                              ),
                              title: Text(
                                item.name,
                                style: const TextStyle(fontFamily: "Myfont"),
                              ),
                              subtitle: Text(
                                item.state == "0" ? "غير مكتملة" : "مكتملة",
                                style: TextStyle(
                                    fontFamily: "Myfont",
                                    color: item.state == "0"
                                        ? Colors.redAccent
                                        : Colors.greenAccent),
                              ),
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
                                    icon: const Icon(Icons.note_alt_outlined),
                                    iconSize: 25,
                                  ),
                                )
                              ]),
                              onTap: (() {
                                Navigator.of(context).push(MaterialPageRoute(
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
  }
}
