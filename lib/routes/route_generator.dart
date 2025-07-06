import 'package:flutter/material.dart';
import 'package:pro_mobile/screens/ability/ability_data_screen.dart';
import 'package:pro_mobile/screens/alarm/alarm_board_screen.dart';
import 'package:pro_mobile/screens/alarm/alarm_description_screen.dart';
import 'package:pro_mobile/screens/alarm/alarm_screen.dart';
import 'package:pro_mobile/screens/armory/armory_screen.dart';
import 'package:pro_mobile/screens/learning/article/article_view_screen.dart';
import 'package:pro_mobile/screens/auth/login_screen.dart';
import 'package:pro_mobile/screens/auth/register_screen.dart';
import 'package:pro_mobile/screens/home_screen.dart';
import 'package:pro_mobile/screens/learning/bujuk/bujuk_view_screen.dart';
import 'package:pro_mobile/screens/learning/e_learning/e_learning_view_screen.dart';
import 'package:pro_mobile/screens/logistics/logistics_screen.dart';
import 'package:pro_mobile/screens/permission/permission_screen.dart';
import 'package:pro_mobile/screens/permission/vehicle_permission_screen.dart';
import 'package:pro_mobile/screens/permission/vehicle_van_permission_screen.dart';
import 'package:pro_mobile/screens/position/detail_position_screen.dart';
import 'package:pro_mobile/screens/presence/presence_screen.dart';
import 'package:pro_mobile/screens/profile/ability_screen.dart';
import 'package:pro_mobile/screens/profile/form/update__profile_screen.dart';
import 'package:pro_mobile/screens/profile/profile_screen.dart';
import 'package:pro_mobile/screens/report/report_armory_screen.dart';
import 'package:pro_mobile/screens/report/report_logistics.dart';
import 'package:pro_mobile/screens/report/report_permission_screen.dart';
import 'package:pro_mobile/screens/report/report_presence_screen.dart';
import 'package:pro_mobile/screens/report/report_suggestion_screen.dart';
import 'package:pro_mobile/screens/report/report_vehicle_permission_screen.dart';
import 'package:pro_mobile/screens/report/report_vehicle_van_permission_screen.dart';
import 'package:pro_mobile/screens/scan_qr/scan_screen.dart';
import 'package:pro_mobile/screens/splash/splash_screen.dart';
import 'package:pro_mobile/screens/staff/staff_screen.dart';
import 'package:pro_mobile/screens/suggestion/suggestion_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/update_profile':
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());
      case '/ability':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AbilityScreen(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/home':
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(
                  title: "Home",
                ));
      case '/scan_qr':
        return MaterialPageRoute(builder: (_) => const ScanScreen());
      case '/detail_kostrad':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => DetailPositionScreen(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/article_view':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ArticleViewScreen(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/e_learning_view':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ELearningViewScreen(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/bujuk_view':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => BujukViewScreen(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/presence':
        return MaterialPageRoute(builder: (_) => const PresenceScreen());
      case '/permission':
        return MaterialPageRoute(builder: (_) => const PermissionScreen());
      case '/vehicle_permission':
        return MaterialPageRoute(builder: (_) => const VehiclePermissionScreen());
      case '/vehicle_van_permission':
        return MaterialPageRoute(builder: (_) => const VehicleVanPermissionScreen());
      case '/alarm':
        return MaterialPageRoute(builder: (_) => const AlarmScreen());
      case '/alarm_board':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AlarmBoardScreen(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/alarm_description':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AlarmDescriptionScreen(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/armory':
        return MaterialPageRoute(builder: (_) => const ArmoryScreen());
      case '/logistics':
        return MaterialPageRoute(builder: (_) => const LogisticsScreen());
      case '/ability_data':
        return MaterialPageRoute(builder: (_) => const AbilityDataScreen());
      case '/staff':
        return MaterialPageRoute(builder: (_) => const StaffScreen());
      case '/suggestion':
        return MaterialPageRoute(builder: (_) => const SuggestionScreen());
      case '/report_presence':
        return MaterialPageRoute(builder: (_) => const ReportPresenceScreen());
      case '/report_permission':
        return MaterialPageRoute(builder: (_) => const ReportPermissionScreen());
      case '/report_vehicle_van_permission':
        return MaterialPageRoute(builder: (_) => const ReportVehicleVanPermissionScreen());
      case '/report_vehicle_permission':
        return MaterialPageRoute(builder: (_) => const ReportVehiclePermissionScreen());
      case '/report_armory':
        return MaterialPageRoute(builder: (_) => const ReportArmoryScreen());
      case '/report_logistics':
        return MaterialPageRoute(builder: (_) => const ReportLogisticsScreen());
      case '/report_suggestion':
        return MaterialPageRoute(builder: (_) => const ReportSuggestionScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
