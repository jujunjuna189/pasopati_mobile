import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pro_mobile/routes/route_generator.dart';
import 'package:pro_mobile/service/fire_background.dart';
import 'package:pro_mobile/service/local_notification_service.dart';
import 'package:pro_mobile/service/terminate_background_service.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var firebase = await Firebase.initializeApp();
  print(firebase.options);
  FireBackground.instance.initialized();
  LocalNotificationService.instance.initialize();
  TerminateBackgroundService.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: buildMaterialColor(bgDanger),
          bottomAppBarColor: buildMaterialColor(bgDanger)),
      initialRoute: '/splash',
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: EasyLoading.init(),
    );
  }
}
