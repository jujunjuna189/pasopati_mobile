import 'package:shared_preferences/shared_preferences.dart';
import 'package:pro_mobile/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class AuthRepo {
  AuthRepo._privateContructor();
  static final AuthRepo instance = AuthRepo._privateContructor();

  final _uriLogin = Api.login;
  final _uriRegister = Api.register;

  Future login(Map<String, dynamic> body) async {
    try {
      final response = await http.post(Uri.parse(_uriLogin), body: body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Iterable iterable = jsonResponse['data'];
        //Set session
        setSession("user", iterable.first);
        ToastLoader.instance.hideLoader();
        ToastAlert.instance.showMessage(
            customMessage: true, customMessageText: "Berhasil Masuk");
        return true;
      }
    } catch (e) {
      ToastLoader.instance.hideLoader();
      ToastAlert.instance.showMessage(serverError: true);
    }
    ToastLoader.instance.hideLoader();
    ToastAlert.instance.showMessage(
        customMessage: true,
        customMessageText: "Gagal Masuk, Periksa data kembali");
    return false;
  }

  Future register(Map<String, dynamic> body) async {
    try {
      final response = await http.post(Uri.parse(_uriRegister), body: body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Iterable iterable = jsonResponse['data'];
        //Set session
        setSession("user", iterable.first);
        ToastLoader.instance.hideLoader();
        ToastAlert.instance.showMessage(
            customMessage: true, customMessageText: "Berhasil daftar akun");
        return true;
      }
    } catch (e) {
      ToastLoader.instance.hideLoader();
      ToastAlert.instance.showMessage(serverError: true);
    }
    ToastLoader.instance.hideLoader();
    ToastAlert.instance.showMessage(
        customMessage: true, customMessageText: "Gagal daftar akun");
    return false;
  }

  Future logout() async {
    final preference = await SharedPreferences.getInstance();
    preference.clear();
    // preference.remove("user");
    ToastLoader.instance.hideLoader();
    ToastAlert.instance.showMessage(
        customMessage: true, customMessageText: "Berhasil keluar aplikasi");
    return true;
  }

  Future<void> setSession(String key, Map<String, dynamic> value) async {
    final preference = await SharedPreferences.getInstance();
    if (preference.containsKey(key)) {
      preference.remove(key);
    }
    preference.setString(key, jsonEncode(value));
  }

  Future getSession(String key) async {
    final preference = await SharedPreferences.getInstance();
    if (preference.containsKey(key)) {
      final data = jsonDecode(preference.getString(key).toString());
      return data;
    } else {
      return null;
    }
  }

  Future removeSession(String key) async {
    final preference = await SharedPreferences.getInstance();
    if (preference.containsKey(key)) {
      preference.remove(key);
      return true;
    } else {
      return false;
    }
  }
}
