import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class VehicleVanPermissionRepo {
  VehicleVanPermissionRepo._privateConstructor();
  static final VehicleVanPermissionRepo instance =
      VehicleVanPermissionRepo._privateConstructor();

  final _perizinanRanpurStore = Api.perizinanRanpurStore;
  final _reportPerizinanRanpur = Api.reportPerizinanRanpur;

  Future report(Map<String, dynamic> body) async {
    try {
      final response =
          await http.post(Uri.parse(_reportPerizinanRanpur), body: body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Iterable iterable = jsonResponse['data'];
        //return data response
        ToastLoader.instance.hideLoader();
        return iterable;
      }
    } catch (e) {
      ToastLoader.instance.hideLoader();
      ToastAlert.instance.showMessage(serverError: true);
    }
    ToastLoader.instance.hideLoader();
    ToastAlert.instance.showMessage(failed: true);
    return false;
  }

  Future store(Map<String, dynamic> body) async {
    try {
      final response =
          await http.post(Uri.parse(_perizinanRanpurStore), body: body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Iterable iterable = jsonResponse['data'];
        //Set session permission with today
        AuthRepo.instance.setSession("vehicle_van_permission", iterable.first);
        //return data response
        ToastLoader.instance.hideLoader();
        ToastAlert.instance.showMessage(success: true);
        return iterable.first;
      }
    } catch (e) {
      ToastLoader.instance.hideLoader();
      ToastAlert.instance.showMessage(serverError: true);
    }
    ToastLoader.instance.hideLoader();
    ToastAlert.instance.showMessage(failed: true);
    return false;
  }
}
