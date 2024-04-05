import 'package:pro_mobile/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class AbilityRepo {
  AbilityRepo._privateConstructor();
  static final AbilityRepo instance = AbilityRepo._privateConstructor();

  final _kemampuanShow = Api.kemampuanShow;

  Future show(Map<String, dynamic> body) async {
    try {
      final response = await http.post(Uri.parse(_kemampuanShow), body: body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Iterable iterable = jsonResponse['data'];
        //return data response
        return iterable.first;
      }
    } catch (e) {
      ToastLoader.instance.hideLoader();
      ToastAlert.instance.showMessage(serverError: true);
    }
    ToastLoader.instance.hideLoader();
    ToastAlert.instance.showMessage(empty: true);
    return false;
  }
}
