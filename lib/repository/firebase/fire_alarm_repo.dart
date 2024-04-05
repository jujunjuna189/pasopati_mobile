import 'package:firebase_database/firebase_database.dart';
import 'package:pro_mobile/widgets/toast/toast_alert.dart';

class FireAlarmRepo {
  FireAlarmRepo._privateContructor();
  static final FireAlarmRepo instance = FireAlarmRepo._privateContructor();

  final DatabaseReference _ref = FirebaseDatabase.instance.ref("alarm");

  Future store(Map<String, dynamic> body) async {
    await _ref.set(body);
  }

  Future onChange({Function? callback}) async {
    _ref.onValue.listen((event) {
      try {
        callback!(event.snapshot.value);
      } catch (e) {
        ToastAlert.instance.showMessage(
            customMessage: true,
            customMessageText: "Belum ada data dalam firebase");
      }
    }, onError: (error) {
      ToastAlert.instance.showMessage(
          customMessage: true, customMessageText: "Error firebase on change");
    });
  }
}
