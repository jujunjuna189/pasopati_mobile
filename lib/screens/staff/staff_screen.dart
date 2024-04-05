import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/staff_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/shimmer/shimmer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({Key? key}) : super(key: key);

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  List _staffList = [];

  @override
  void initState() {
    getStaffList();
    super.initState();
  }

  void getStaffList() async {
    await StaffRepo.instance.show({}).then((value) {
      if (value != false) {
        _staffList = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Staff"),
      ),
      body: _staffList.isEmpty ? buildShimmerList() : buildStaffList(),
    );
  }

  Widget buildShimmerList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 8,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: bgWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.circular(
                      height: 16,
                      width: 150,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ],
              )),
        );
      },
    );
  }

  Widget buildStaffList() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      physics: const BouncingScrollPhysics(),
      children: _staffList.map((value) {
        return GestureDetector(
          onTap: (() async {
            await launchUrl(Uri.parse(value['url'].toString()));
          }),
          child: Container(
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
            child: Text(
              value['name'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }
}
