import 'package:pro_mobile/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class BaseRepo {
  BaseRepo._privateConstructor();
  static final BaseRepo instance = BaseRepo._privateConstructor();

  final _pangkalanShow = Api.pangkalanShow;

  Future show(Map<String, dynamic> body) async {
    try {
      final response = await http.post(Uri.parse(_pangkalanShow), body: body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Iterable iterable = jsonResponse['data'];
        //return data response
        return iterable;
      }
    } catch (e) {
      ToastLoader.instance.hideLoader();
      ToastAlert.instance.showMessage(serverError: true);
    }
    ToastLoader.instance.hideLoader();
    ToastAlert.instance.showMessage(empty: true);
    return [];
  }
}
