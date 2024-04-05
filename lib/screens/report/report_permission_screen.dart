import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/permission_repo.dart';
import 'package:pro_mobile/utils/colors.dart';

class ReportPermissionScreen extends StatefulWidget {
  const ReportPermissionScreen({Key? key}) : super(key: key);

  @override
  State<ReportPermissionScreen> createState() => _ReportPermissionScreenState();
}

class _ReportPermissionScreenState extends State<ReportPermissionScreen> {
  List _reportList = [];

  @override
  void initState() {
    getReport();
    super.initState();
  }

  void getReport() async {
    await PermissionRepo.instance.report({}).then((value) {
      _reportList = value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Rekap Data Perizinan"),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value['user_name'] ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(value['created_at'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Waktu Masuk"),
                  Text(value['masuk'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Waktu Keluar"),
                  Text(value['keluar'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Tujuan Keluar"),
                  Text(value['tujuan'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
