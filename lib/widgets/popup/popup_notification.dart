import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/notification_repo.dart';
import 'package:pro_mobile/utils/colors.dart';

class PopupNotification {
  PopupNotification._privateConstructor();
  static final PopupNotification instance =
      PopupNotification._privateConstructor();
  List notif = [];

  Future notificationOnTap(int id) async {
    await NotificationRepo.instance.notificationRead(id);
    notif = await NotificationRepo.instance.getNotif();
  }

  void notificationNavigation(BuildContext context, int id) {
    Map<String, dynamic> notification =
        notif.where((element) => element["id"] == id).first;
    final split = notification['code'].toString().split("-");
    if (split.first == "0") {
      Navigator.of(context).pushNamed("/alarm_description",
          arguments: json.encode(notification));
    }
  }

  void showPopup(BuildContext context, {String data = "", Function? callback}) {
    notif = json.decode(data);
    showDialog(
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        context: context,
        builder: (context) {
          // for detect position object
          return StatefulBuilder(builder: (context, setState) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned(
                  right: 50,
                  top: MediaQuery.of(context).size.height / 13,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: 250,
                      constraints: const BoxConstraints(
                        maxHeight: 300,
                      ),
                      decoration: BoxDecoration(
                        color: bgWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: bgLightPrimary, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Notifikasi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: notif.map((value) {
                                return Material(
                                  color: !value["read"]
                                      ? Colors.black12
                                      : Colors.white,
                                  child: InkWell(
                                    splashColor: Colors.white24,
                                    onTap: (() async {
                                      notificationOnTap(value['id'])
                                          .then((val) {
                                        notificationNavigation(
                                            context, value["id"]);
                                        setState(() {});
                                      });
                                    }),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: bgLightTransparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: const [
                                                      Icon(
                                                        Icons
                                                            .notifications_none_outlined,
                                                        size: 20,
                                                        color: Colors.black87,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        value['title'] ?? "",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(value['content'] ??
                                                          ""),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  notif.isEmpty
                                      ? "Belum ada notifikasi"
                                      : "Lainnya...",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          });
        });
  }
}
