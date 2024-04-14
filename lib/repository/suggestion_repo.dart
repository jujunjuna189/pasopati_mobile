import 'package:pro_mobile/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class SuggestionRepo {
  SuggestionRepo._privateContructor();
  static final SuggestionRepo instance = SuggestionRepo._privateContructor();

  final _uriSuggestion = Api.suggestion;
  final _reportSaran = Api.reportSuggestion;

  Future report(Map<String, dynamic> body) async {
    try {
      final response =
          await http.post(Uri.parse(_reportSaran), body: body);

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
  }

  Future store(Map<String, dynamic> body) async {
    try {
      final response = await http.post(Uri.parse(_uriSuggestion), body: body);
      ToastLoader.instance.hideLoader();

      if (response.statusCode == 200) {
        ToastAlert.instance.showMessage(customMessage: true, customMessageText: 'Berhasil kirim saran dan masukan');
        //return data response
        return true;
      }else{
        ToastAlert.instance.showMessage(customMessage: true, customMessageText: 'Permintaan gagal');
        return false;
      }
    } catch (e) {
      ToastLoader.instance.hideLoader();
      ToastAlert.instance.showMessage(serverError: true);
      return false;
    }
  }
}
