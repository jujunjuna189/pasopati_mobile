import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';

class TerminateBackgroundService {
  TerminateBackgroundService._privateConstructor();
  static final TerminateBackgroundService instance = TerminateBackgroundService._privateConstructor();

  void initialize() async {
    final service = FlutterBackgroundService();

    await service.configure(
        iosConfiguration: IosConfiguration(
            autoStart: true,
            onForeground: onStart,
            onBackground: onIosBackground,
        ),
        androidConfiguration: AndroidConfiguration(
            onStart: onStart,
            autoStart: true,
            isForegroundMode: true,
        ),
    );
  }

  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    print("IOS Background Service");
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();
    // bring to foreground
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      print("Oke android background service");
    });
  }
}