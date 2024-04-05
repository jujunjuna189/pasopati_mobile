import 'dart:convert';

import 'package:pro_mobile/repository/auth_repo.dart';

class NotificationRepo {
  NotificationRepo._privateConstructor();
  static final NotificationRepo instance =
      NotificationRepo._privateConstructor();

  Future<List> getNotif({int id = 0, String orderBy = "asc"}) async {
    List notification = [];
    await AuthRepo.instance.getSession("notification").then((value) {
      if (value != null) {
        notification = json.decode(value["notif"]);
        //Get by id
        if (id != 0) {
          notification =
              notification.where((element) => element["id"] == id).toList();
        }

        if (orderBy == "desc") {
          notification.sort((a, b) => -a["id"].compareTo(b["id"]));
        }
      }
    });

    return notification;
  }

  Future setNotif(
      {String title = "",
      String subTitle = "",
      String content = "",
      String code = ""}) async {
    await AuthRepo.instance.getSession("notification").then((value) {
      List<Map<String, dynamic>> dataBatch = [
        {
          "id": value == null ? 1 : generateId(value),
          "title": title,
          "sub_title": subTitle,
          "content": content,
          "code": code,
          "read": false,
        }
      ];

      String bundle = json.encode(dataBatch);

      if (value != null) {
        updateNotification(json.encode(value), bundle);
      } else {
        createNotification(bundle);
      }
    });
  }

  int generateId(value) {
    List notification = json.decode(value["notif"]);
    return notification.length + 1;
  }

  void createNotification(String value) async {
    await AuthRepo.instance.setSession("notification", {
      "notif": value,
    });
  }

  void updateNotification(String oldData, String newData) {
    Map<String, dynamic> notifOld = json.decode(oldData);
    List notification = json.decode(notifOld["notif"]);
    //Add local notif
    notification.add(json.decode(newData)[0]);
    String bundle = json.encode(notification);
    createNotification(bundle);
  }

  Future notificationRead(int id) async {
    List notification = await getNotif();
    int index = notification.indexWhere((element) => element["id"] == id);
    notification[index]["read"] = true;
    //Add notif update
    String bundle = json.encode(notification);
    createNotification(bundle);
  }
}
