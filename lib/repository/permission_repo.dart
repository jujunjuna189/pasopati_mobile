import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class PermissionRepo {
  PermissionRepo._privateConstructor();
  static final PermissionRepo instance = PermissionRepo._privateConstructor();

  final _perizinanStore = Api.perizinanStore;
  final _reportPerizinan = Api.reportPerizinan;

  Future report(Map<String, dynamic> body) async {
    try {
      final response = await http.post(Uri.parse(_reportPerizinan), body: body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Iterable iterable = jsonResponse['data'];
        //return data response
        ToastLoader.instance.hideLoader();
        return iterable;
      }

      if(response.statusCode != 200 || response.statusCode != 500){
        var jsonResponse = jsonDecode(response.body);
        ToastAlert.instance.showMessage(customMessage: true, customMessageText: jsonResponse['status'] ?? '');
        return [];
      }
    } catch (e) {
      ToastLoader.instance.hideLoader();
      ToastAlert.instance.showMessage(serverError: true);
      return [];
    }
    ToastLoader.instance.hideLoader();
    ToastAlert.instance.showMessage(failed: true);
    return [];
  }

  Future store(Map<String, dynamic> body) async {
    try {
      final response = await http.post(Uri.parse(_perizinanStore), body: body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Iterable iterable = jsonResponse['data'];
        //Set session permission with today
        AuthRepo.instance.setSession("permission", iterable.first);
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
