import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  LocalNotificationService._privateConstructor();
  static final LocalNotificationService instance = LocalNotificationService._privateConstructor();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    IOSInitializationSettings iosInitializationSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetail() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "channel_id",
      "channel_name",
      channelDescription: "description",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({required int id, required String title, required String body}) async {
    final details = await _notificationDetail();
    await _localNotificationService.show(id, title, body, details);
  }

  void onSelectNotification(String? payload) {
    print("Payload $payload");
  }

  void _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    print("id $id");
  }
}