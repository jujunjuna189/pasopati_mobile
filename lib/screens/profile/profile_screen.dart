import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/toast/toast_alert.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> _user = {};

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    await AuthRepo.instance.getSession("user").then((value) {
      setState(() {
        _user = value;
      });
    });
  }

  void onGoing() {
    ToastAlert.instance.showMessage(
        customMessage: true, customMessageText: "Fitur Belum Tersedia");
  }

  void updateProfile() async {
    await Navigator.of(context).pushNamed("/update_profile").then((value) {
      getUser();
    });
  }

  void logout() {
    AuthRepo.instance.logout();
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("PROFILE"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        physics: const ScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: bgLightPrimary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      _user['name'] == null
                          ? ''
                          : _user['name']
                              .toString()
                              .substring(0, 2)
                              .toUpperCase(),
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width / 20),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _user['name'] ?? '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Nrp"),
                    Text(
                      _user['email'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Pangkat"),
                    Text(
                      _user['pangkat'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Korp"),
                    Text(
                      _user['korp'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Satuan"),
                    Text(
                      _user['satuan'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tempat Lahir"),
                    Text(
                      _user['tempat_lahir'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tanggal Lahir"),
                    Text(
                      _user['tgl_lahir'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Agama"),
                    Text(
                      _user['agama'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Gol Darah"),
                    Text(
                      _user['gol_darah'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Sumber Pa"),
                    Text(
                      _user['sumber_pa'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Jabatan"),
                    Text(
                      _user['jabatan'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: bgWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Senjata"),
                    Text(
                      _user['senjata'] ?? '...',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (() {
                  updateProfile();
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: const BoxDecoration(
                    color: bgWhite,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Ubah Profile',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
              _user['role'] != 1
                  ? GestureDetector(
                      onTap: (() {
                        Navigator.of(context).pushNamed("/ability",
                            arguments: jsonEncode({"user_id": _user['id']}));
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: const BoxDecoration(
                          color: bgWhite,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Data Kemampuan',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              const Divider(
                height: 2,
                color: Colors.black12,
              ),
              GestureDetector(
                onTap: (() {
                  onGoing();
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: const BoxDecoration(
                    color: bgWhite,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Tentang Kami',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (() {
                  onGoing();
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: const BoxDecoration(
                    color: bgWhite,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Setting',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 2,
                color: Colors.black12,
              ),
              GestureDetector(
                onTap: (() {
                  logout();
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: const BoxDecoration(
                    color: bgWhite,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Logout',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
