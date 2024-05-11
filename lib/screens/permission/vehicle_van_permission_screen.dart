import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/repository/permission_repo.dart';
import 'package:pro_mobile/repository/vehicle_van_permission_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/popup/popup_permission.dart';
import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class VehicleVanPermissionScreen extends StatefulWidget {
  const VehicleVanPermissionScreen({Key? key}) : super(key: key);

  @override
  State<VehicleVanPermissionScreen> createState() =>
      _VehicleVanPermissionScreenState();
}

class _VehicleVanPermissionScreenState
    extends State<VehicleVanPermissionScreen> {
  Map<String, dynamic> _user = {};
  final String _codeAccess = "04";
  Map<String, dynamic> _permission = {};
  bool _statusPermissionOutToday = false;
  bool _statusPermissionInToday = false;

  @override
  void initState() {
    getUser();
    getPermissionToday();
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

  void getPermissionToday() async {
    String formatDateNow =
        dateNowFormatter(DateTime.now().toString(), "yyyy-MM-dd");
    await AuthRepo.instance.getSession("vehicle_van_permission").then((value) {
      if (value != null) {
        String formatDatePermission =
            dateNowFormatter(value['created_at'], "yyyy-MM-dd");
        if (formatDatePermission == formatDateNow) {
          if (value['keluar'] != null) {
            _statusPermissionOutToday = true;
          } else {
            _statusPermissionOutToday = false;
          }
          if (value['masuk'] != null) {
            _statusPermissionInToday = true;
          } else {
            _statusPermissionInToday = false;
          }
          _permission = value;
        } else {
          _statusPermissionOutToday = false;
          _statusPermissionInToday = false;
        }
      }

      setState(() {});
    });
  }

  void permissionOut() async {
    await Navigator.of(context).pushNamed("/scan_qr").then((code) {
      String json = jsonDecode(code.toString()).toString();
      var splitText = json.split("-");
      if (_codeAccess == splitText.first) {
        PopupPermission.instance.showPopup(context, callback: ((value) {
          permissionRequest(
              userId: _user["id"].toString(),
              keluar: true,
              tujuan: value["destination"],
              jenisKendaraan: value["type_vihicle"],
              qrcode: json);
        }));
      } else {
        ToastAlert.instance.showMessage(
            customMessage: true, customMessageText: "Kode tidak sesuai");
      }
    });
  }

  void permissionIn() async {
    await Navigator.of(context).pushNamed("/scan_qr").then((code) {
      String json = jsonDecode(code.toString()).toString();
      var splitText = json.split("-");
      if (_codeAccess == splitText.first) {
        permissionRequest(
            userId: _user["id"].toString(), masuk: true, qrcode: json);
      } else {
        ToastAlert.instance.showMessage(
            customMessage: true, customMessageText: "Kode tidak sesuai");
      }
    });
  }

  void permissionRequest(
      {String userId = "",
      bool keluar = false,
      bool masuk = false,
      String tujuan = "",
      String jenisKendaraan = "",
      String qrcode = ""}) async {
    ToastLoader.instance.showLoader();
    Map<String, dynamic> dataBatch = {
      "user_id": userId,
      "keluar": keluar ? DateTime.now().toString() : "",
      "masuk": masuk ? DateTime.now().toString() : "",
      "tujuan": tujuan,
      "jenis_kendaraan": jenisKendaraan,
      "qrcode": qrcode
    };

    await VehicleVanPermissionRepo.instance.store(dataBatch).then((value) {
      getPermissionToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("PERIZINAN KENDARAAN"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: bgWhite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Izin Keluar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _statusPermissionOutToday
                          ? buildSuccessOutPermission(
                              text: _permission['keluar'] != null
                                  ? dateNowFormatter(
                                      _permission['keluar'], "HH:mm:ss")
                                  : "",
                              tujuan: _permission['tujuan'] ?? "")
                          : buildFailedPermission(),
                    ],
                  ),
                  GestureDetector(
                    onTap: (() {
                      permissionOut();
                    }),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: bgLightPrimary),
                        ),
                        child: const Icon(
                          Icons.qr_code_scanner,
                          color: textDanger,
                          size: 30,
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: bgWhite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Izin Masuk",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _statusPermissionInToday
                          ? buildSuccessInPermission(
                              text: _permission['masuk'] != null
                                  ? dateNowFormatter(
                                      _permission['masuk'], "HH:mm:ss")
                                  : "")
                          : buildFailedPermission(),
                    ],
                  ),
                  GestureDetector(
                    onTap: (() {
                      permissionIn();
                    }),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: bgLightPrimary),
                        ),
                        child: const Icon(
                          Icons.qr_code_scanner,
                          color: textSuccess,
                          size: 30,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Success Out Permission
  Widget buildSuccessOutPermission({String text = "", String tujuan = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tujuan"),
        const SizedBox(
          height: 3,
        ),
        Text(
          tujuan,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text("Waktu Keluar"),
        const SizedBox(
          height: 3,
        ),
        Row(
          children: [
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.check_circle,
              color: textSuccess,
              size: 11,
            ),
          ],
        ),
      ],
    );
  }

  // Success In Permission
  Widget buildSuccessInPermission({String text = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Waktu Masuk"),
        const SizedBox(
          height: 3,
        ),
        Row(
          children: [
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.check_circle,
              color: textSuccess,
              size: 11,
            ),
          ],
        ),
      ],
    );
  }

  // Failed Permission
  Widget buildFailedPermission({String text = ""}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: bgDanger,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "Belum ada data",
        style: TextStyle(color: textLight, fontWeight: FontWeight.bold),
      ),
    );
  }
}
