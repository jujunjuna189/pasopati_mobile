import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_mobile/repository/armory_repo.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class ArmoryScreen extends StatefulWidget {
  const ArmoryScreen({Key? key}) : super(key: key);

  @override
  State<ArmoryScreen> createState() => _ArmoryScreenState();
}

class _ArmoryScreenState extends State<ArmoryScreen> {
  Map<String, dynamic> _user = {};
  final String _codeAccess = "02";
  Map<String, dynamic> _armory = {};
  bool _statusArmoryOutToday = false;
  bool _statusArmoryInToday = false;

  @override
  void initState() {
    getUser();
    getArmoryToday();
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

  void getArmoryToday() async {
    String formatDateNow =
        dateNowFormatter(DateTime.now().toString(), "yyyy-MM-dd");
    await AuthRepo.instance.getSession("armory").then((value) {
      if (value != null) {
        String formatDatePermission =
            dateNowFormatter(value['created_at'], "yyyy-MM-dd");
        if (formatDatePermission == formatDateNow) {
          if (value['keluar'] != null) {
            _statusArmoryOutToday = true;
          } else {
            _statusArmoryOutToday = false;
          }
          if (value['masuk'] != null) {
            _statusArmoryInToday = true;
          } else {
            _statusArmoryInToday = false;
          }
          _armory = value;
        } else {
          _statusArmoryOutToday = false;
          _statusArmoryInToday = false;
        }
      }

      setState(() {});
    });
  }

  void _take() async {
    await Navigator.of(context).pushNamed("/scan_qr").then((code) {
      String json = jsonDecode(code.toString()).toString();
      var splitText = json.split("-");
      if (_codeAccess == splitText.first) {
        String batrai = splitText.length > 1 ? splitText[1].toString() : "";
        armoryRequest(
            userId: _user["id"].toString(),
            batraiKeluar: batrai,
            keluar: true,
            qrcode: json);
      } else {
        ToastAlert.instance.showMessage(
            customMessage: true, customMessageText: "Kode tidak sesuai");
      }
    });
  }

  void _return() async {
    await Navigator.of(context).pushNamed("/scan_qr").then((code) {
      String json = jsonDecode(code.toString()).toString();
      var splitText = json.split("-");
      if (_codeAccess == splitText.first) {
        String batrai = splitText.length > 1 ? splitText[1].toString() : "";
        armoryRequest(
            userId: _user["id"].toString(),
            batraiMasuk: batrai,
            masuk: true,
            qrcode: json);
      } else {
        ToastAlert.instance.showMessage(
            customMessage: true, customMessageText: "Kode tidak sesuai");
      }
    });
  }

  void armoryRequest(
      {String userId = "",
      String batraiKeluar = "",
      String batraiMasuk = "",
      bool keluar = false,
      bool masuk = false,
      String qrcode = ""}) async {
    ToastLoader.instance.showLoader();
    Map<String, dynamic> dataBatch = {
      "user_id": userId,
      "batrai_keluar": batraiKeluar,
      "batrai_masuk": batraiMasuk,
      "keluar": keluar ? DateTime.now().toString() : "",
      "masuk": masuk ? DateTime.now().toString() : "",
      "qrcode": qrcode
    };

    await ArmoryRepo.instance.store(dataBatch).then((value) {
      getArmoryToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("GUDANG SENJATA"),
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
                        "Kembalikan Senjata",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _statusArmoryInToday
                          ? buildSuccessArmory(
                              text: _armory['masuk'] != null
                                  ? dateNowFormatter(
                                      _armory['masuk'],
                                      "HH:mm:ss",
                                    )
                                  : "",
                              batrai: _armory['batrai_masuk'] ?? "")
                          : buildFailedArmory(),
                    ],
                  ),
                  GestureDetector(
                    onTap: (() {
                      _return();
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
                        "Ambil Senjata",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _statusArmoryOutToday
                          ? buildSuccessArmory(
                              text: _armory['keluar'] != null
                                  ? dateNowFormatter(
                                      _armory['keluar'],
                                      "HH:mm:ss",
                                    )
                                  : "",
                              batrai: _armory['batrai_keluar'] ?? "")
                          : buildFailedArmory(),
                    ],
                  ),
                  GestureDetector(
                    onTap: (() {
                      _take();
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
  Widget buildSuccessArmory({String text = "", String batrai = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Batrai : "),
            const SizedBox(
              width: 5,
            ),
            Text(
              batrai,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Text("Waktu : "),
            const SizedBox(
              width: 5,
            ),
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
  Widget buildFailedArmory({String text = ""}) {
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
