import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastLoader{
  ToastLoader._privateContructor();
  static final ToastLoader instance = ToastLoader._privateContructor();

  void configLoader(){
    EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.opacity;
  }

  void showLoader() {
    configLoader();
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
  }

  void hideLoader(){
    EasyLoading.dismiss();
  }
}