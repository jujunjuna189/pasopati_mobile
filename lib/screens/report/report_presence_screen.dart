import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_mobile/repository/presence_repo.dart';
import 'package:pro_mobile/utils/colors.dart';

class ReportPresenceScreen extends StatefulWidget {
  const ReportPresenceScreen({Key? key}) : super(key: key);

  @override
  State<ReportPresenceScreen> createState() => _ReportPresenceScreenState();
}

class _ReportPresenceScreenState extends State<ReportPresenceScreen> {
  List _reportList = [];

  @override
  void initState() {
    getReport();
    super.initState();
  }

  String dateNowFormatter(String date, String format) {
    final DateTime dateNow = DateTime.parse(date);
    final DateFormat formatter = DateFormat(format);
    String formatDateNow = formatter.format(dateNow);
    return formatDateNow;
  }

  void getReport() async {
    await PresenceRepo.instance.report({}).then((value) {
      _reportList = value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Rekap Data Absensi"),
      ),
      body: buildReportList(),
    );
  }

  Widget buildReportList() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: _reportList.map((value) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: bgLightPrimary))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value['user_name'] ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Tangal & Waktu"),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(value['created_at'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: bgLightTransparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  value['ket'],
                  style: const TextStyle(
                      color: textDark, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
