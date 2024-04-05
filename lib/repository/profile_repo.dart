import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class ProfileRepo {
  ProfileRepo._privateContructor();
  static final ProfileRepo instance = ProfileRepo._privateContructor();

  final _uriUpdateProfile = Api.updateProfile;

  Future store(Map<String, dynamic> body) async {
    try {
      final response =
          await http.post(Uri.parse(_uriUpdateProfile), body: body);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Iterable iterable = jsonResponse['data'];
        //Set session
        AuthRepo.instance.setSession("user", iterable.first);
        ToastLoader.instance.hideLoader();
        ToastAlert.instance.showMessage(success: true);
        return true;
      }
      ToastAlert.instance.showMessage(
          customMessage: true,
          customMessageText: jsonEncode(jsonResponse["message"]));
      return false;
    } catch (e) {
      ToastLoader.instance.hideLoader();
      ToastAlert.instance.showMessage(serverError: true);
    }
    ToastLoader.instance.hideLoader();
    ToastAlert.instance.showMessage(failed: true);
    return false;
  }
}
