import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/suggestion_repo.dart';
import 'package:pro_mobile/utils/colors.dart';

class ReportSuggestionScreen extends StatefulWidget {
  const ReportSuggestionScreen({Key? key}) : super(key: key);

  @override
  State<ReportSuggestionScreen> createState() =>
      _ReportSuggestionScreenState();
}

class _ReportSuggestionScreenState
    extends State<ReportSuggestionScreen> {
  List _reportList = [];

  @override
  void initState() {
    getReport();
    super.initState();
  }

  void getReport() async {
    await SuggestionRepo.instance.report({}).then((value) {
      _reportList = value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Rekap Data Saran & Masukan"),
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
              Text(
                value['from_display'] ?? '',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(value['created_at'] ?? '',),
              const SizedBox(
                height: 10,
              ),
              const Text("Saran dan Masukan", style: TextStyle(fontWeight: FontWeight.bold),),
              Text(value['message'] ?? '',),
            ],
          ),
        );
      }).toList(),
    );
  }
}
