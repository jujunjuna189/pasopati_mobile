import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pro_mobile/repository/presence_repo.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/popup/popup_presence.dart';
import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class PresenceScreen extends StatefulWidget {
  const PresenceScreen({Key? key}) : super(key: key);

  @override
  State<PresenceScreen> createState() => _PresenceScreenState();
}

class _PresenceScreenState extends State<PresenceScreen> {
  Map<String, dynamic> _user = {};
  final String _codeAccess = "06";
  Map<String, dynamic> _presence = {};
  bool _statusPresenceToday = false;
  String _latitude = "";
  String _longitude = "";

  @override
  void initState() {
    getUser();
    getPresenceToday();
    getCurrentLocation();
    super.initState();
  }

  String dateNowFormatter(String date, String format) {
    final DateTime dateNow = DateTime.parse(date);
    final DateFormat formatter = DateFormat(format);
    String formatDateNow = formatter.format(dateNow);
    return formatDateNow;
  }

  void getUser() async {
    await AuthRepo.instance.getSession("user").then((value) {
      setState(() {
        _user = value;
      });
    });
  }

  void getCurrentLocation() async {
    await Geolocator.checkPermission().then((value) async {
      if (value == LocationPermission.denied) {
        await Geolocator.requestPermission();
      } else {
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        // var lastPosition = await Geolocator.getLastKnownPosition();
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
      }
    });
  }

  void getPresenceToday() async {
    String formatDateNow =
        dateNowFormatter(DateTime.now().toString(), "yyyy-MM-dd");
    await AuthRepo.instance.getSession("presence").then((value) {
      if (value != null) {
        String formatDatePresence =
            dateNowFormatter(value['created_at'], "yyyy-MM-dd");
        if (formatDatePresence == formatDateNow) {
          _statusPresenceToday = true;
          _presence = value;
        } else {
          _statusPresenceToday = false;
        }
      }
      setState(() {});
    });
  }

  void onOpenQrCode() async {
    await Navigator.of(context).pushNamed("/scan_qr").then((code) {
      String json = jsonDecode(code.toString()).toString();
      var splitText = json.split("-");
      if (_codeAccess == splitText.first) {
        onPresence(qrcode: json);
      } else {
        ToastAlert.instance.showMessage(
            customMessage: true, customMessageText: "Kode tidak sesuai");
      }
    });
  }

  void onPresence({String qrcode = ""}) {
    PopupPresence.instance.showPopup(context, callback: ((value) {
      ToastLoader.instance.showLoader();
      getCurrentLocation();
      String ket = value['ket'];

      Map<String, dynamic> dataBatch = {
        'user_id': _user['id'].toString(),
        'ket': ket,
        'latitude': _latitude,
        'longitude': _longitude,
        'qrcode': qrcode,
      };

      onExecute(dataBatch);
    }));
  }

  void onExecute(Map<String, dynamic> dataBatch) async {
    await PresenceRepo.instance.store(dataBatch).then((value) {
      getPresenceToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("ABSENSI PERSONIL"),
      ),
      body: Center(
        child: _statusPresenceToday
            ? buildSuccessPresence()
            : buildFailedPresence(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          onOpenQrCode();
        }),
        backgroundColor: bgWhite,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: const Icon(
          Icons.upload,
          color: textPrimary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 50,
          )),
    );
  }

  //SuccessPresence
  Widget buildSuccessPresence() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: bgSuccess,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: bgSuccess.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: const Icon(
            Icons.check,
            color: textLight,
            size: 100,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(dateNowFormatter(DateTime.now().toString(), "dd MMMM yyyy")),
        const SizedBox(
          height: 5,
        ),
        Text(
          _user['name'] ?? '',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: bgDanger,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _presence['ket'] ?? '',
            style:
                const TextStyle(color: textLight, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: bgSuccess,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Sudah Absen",
            style: TextStyle(color: textLight, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  //FailedPresence
  Widget buildFailedPresence() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: bgDanger,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: bgDanger.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: const Icon(
            Icons.close,
            color: textLight,
            size: 100,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(dateNowFormatter(DateTime.now().toString(), "dd MMMM yyyy")),
        const SizedBox(
          height: 5,
        ),
        Text(
          _user['name'] ?? '',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: bgDanger,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Belum Absen",
            style: TextStyle(color: textLight, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
