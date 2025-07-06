import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  Map<String, dynamic> _user = {};

  @override
  void initState() {
    getFirstData();
    super.initState();
  }

  void getFirstData() async {
    await getUser();
  }

  Future<void> getUser() async {
    await AuthRepo.instance.getSession("user").then((value) {
      setState(() {
        _user = value;
      });
    });
  }

  void navigation(String routeName) {
    if (_user['role'] == 1 || _user['role'] == '1') {
      Navigator.of(context).pushNamed(routeName);
    } else {
      ToastAlert.instance.showMessage(customMessage: true, customMessageText: "Hanya yang berwenang");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
            decoration: BoxDecoration(
              color: bgWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 50,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Rekap Data",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (() async {
                          navigation("/report_suggestion");
                        }),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: bgLightTransparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                      width: 40, height: 40, child: Image.asset("assets/images/icon/letterbox.png")),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Saran & Masukan",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: (() {
                        navigation("/report_permission");
                      }),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: bgLightTransparent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(width: 40, height: 40, child: Image.asset("assets/images/icon/soldier.png")),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Perizinan",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: (() {
                        navigation("/report_vehicle_van_permission");
                      }),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: bgLightTransparent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset("assets/images/icon/armored-vehicle.png")),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Kendaraan",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Container(
                    padding: const EdgeInsets.only(top: 35, bottom: 40, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: bgWhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 50,
                          offset: const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "YONARMED 9 PASOPATI",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Kontak WhatsApp",
                          style: TextStyle(fontSize: 12, color: Colors.black38, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(width: 100, height: 100, child: Image.asset("assets/images/contact/kontak2.PNG")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("assets/images/logo/c.png"),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
