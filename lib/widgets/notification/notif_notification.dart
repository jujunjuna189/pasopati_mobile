import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/notification_repo.dart';
import 'package:pro_mobile/service/local_notification_service.dart';
import 'package:pro_mobile/widgets/popup/popup_notification.dart';

class NotifNotification extends StatefulWidget {
  const NotifNotification({Key? key}) : super(key: key);

  @override
  State<NotifNotification> createState() => _NotifNotificationState();
}

class _NotifNotificationState extends State<NotifNotification> {
  bool _notifActive = false;

  @override
  void initState() {
    realtimeNotification();
    super.initState();
  }

  void realtimeNotification() {
    Timer.periodic(const Duration(seconds: 1), (_) async {
      await NotificationRepo.instance.getNotif(orderBy: "desc").then((value) {
        int index = value.indexWhere((element) => element["read"] == false);
        if (index != -1 && _notifActive == false) {
          _notifActive = true;
          showLocalPusNotification(value[index]);
          setState(() {});
        }
        if (index == -1 && _notifActive == true) {
          _notifActive = false;
          setState(() {});
        }
      });
    });
  }

  void showLocalPusNotification(Map<String, dynamic> value) async {
    await LocalNotificationService.instance
        .showNotification(id: 0, title: "Alarm Stelling", body: value["title"]);
  }

  void showNotification() {
    NotificationRepo.instance.getNotif(orderBy: "desc").then((value) {
      PopupNotification.instance.showPopup(context, data: json.encode(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        showNotification();
      }),
      child: Stack(
        children: [
          const Icon(Icons.notifications_none_outlined),
          _notifActive
              ? const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.circle,
                    size: 10,
                    color: Colors.red,
                  ))
              : Container(),
        ],
      ),
    );
  }
}
