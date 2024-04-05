import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/repository/logistics_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class LogisticsScreen extends StatefulWidget {
  const LogisticsScreen({Key? key}) : super(key: key);

  @override
  State<LogisticsScreen> createState() => _LogisticsScreenState();
}

class _LogisticsScreenState extends State<LogisticsScreen> {
  Map<String, dynamic> _user = {};
  final String _codeAccess = "03";
  Map<String, dynamic> _logistics = {};
  bool _statusLogisticsOutToday = false;
  bool _statusLogisticsInToday = false;

  @override
  void initState() {
    getUser();
    getLogisticsToday();
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

  void getLogisticsToday() async {
    String formatDateNow =
        dateNowFormatter(DateTime.now().toString(), "yyyy-MM-dd");
    await AuthRepo.instance.getSession("logistics").then((value) {
      if (value != null) {
        String formatDatePermission =
            dateNowFormatter(value['created_at'], "yyyy-MM-dd");
        if (formatDatePermission == formatDateNow) {
          if (value['keluar'] != null) {
            _statusLogisticsOutToday = true;
          } else {
            _statusLogisticsOutToday = false;
          }
          if (value['masuk'] != null) {
            _statusLogisticsInToday = true;
          } else {
            _statusLogisticsInToday = false;
          }
          _logistics = value;
        } else {
          _statusLogisticsOutToday = false;
          _statusLogisticsInToday = false;
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
        logisticsRequest(
            userId: _user["id"].toString(), keluar: true, qrcode: json);
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
        logisticsRequest(
            userId: _user["id"].toString(), masuk: true, qrcode: json);
      } else {
        ToastAlert.instance.showMessage(
            customMessage: true, customMessageText: "Kode tidak sesuai");
      }
    });
  }

  void logisticsRequest(
      {String userId = "",
      bool keluar = false,
      bool masuk = false,
      String qrcode = ""}) async {
    ToastLoader.instance.showLoader();
    Map<String, dynamic> dataBatch = {
      "user_id": userId,
      "keluar": keluar ? DateTime.now().toString() : "",
      "masuk": masuk ? DateTime.now().toString() : "",
      "qrcode": qrcode,
    };

    await LogisticsRepo.instance.store(dataBatch).then((value) {
      getLogisticsToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("LOGISTIK"),
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
                        "Kembalikan Logistik",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _statusLogisticsInToday
                          ? buildSuccessLogistics(
                              text: _logistics['masuk'] != null
                                  ? dateNowFormatter(
                                      _logistics['masuk'],
                                      "HH:mm:ss",
                                    )
                                  : "")
                          : buildFailedLogistics(),
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
                        "Ambil Logistik",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _statusLogisticsOutToday
                          ? buildSuccessLogistics(
                              text: _logistics['keluar'] != null
                                  ? dateNowFormatter(
                                      _logistics['keluar'],
                                      "HH:mm:ss",
                                    )
                                  : "")
                          : buildFailedLogistics(),
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

  // Success Permission
  Widget buildSuccessLogistics({String text = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Waktu Pengambilan"),
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
  Widget buildFailedLogistics({String text = ""}) {
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
