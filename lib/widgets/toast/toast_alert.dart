import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastAlert{
  ToastAlert._privateContructor();
  static final ToastAlert instance = ToastAlert._privateContructor();

  void showMessage({bool success = false, bool empty = false, bool failed = false, bool serverError = false, bool customMessage = false, String customMessageText = ""}) {
    EasyLoading.showToast(
      toastMesage(success: success, empty: empty, failed: failed, serverError: serverError, customMessage: customMessage, customMessageText: customMessageText),
      toastPosition: EasyLoadingToastPosition.center,
      duration: const Duration(milliseconds: 2500)
    );
  }

  String toastMesage({bool success = false, bool empty = false, bool failed = false, bool serverError = false, bool customMessage = false, String customMessageText = ""}) {
    String message = "";
    if(success){
      message = "Permintaan Berhasil";
    }

    if(empty){
      message = "Data Kosong";
    }

    if(failed){
      message = "Permintaan Gagal";
    }

    if(serverError){
      message = "Server Error, Hubungi admin segera";
    }

    if(customMessage){
      message = customMessageText;
    }

    return message;
  }

}