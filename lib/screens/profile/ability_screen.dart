import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/ability_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/page/page_empty.dart';

class AbilityScreen extends StatefulWidget {
  final String data;
  const AbilityScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<AbilityScreen> createState() => _AbilityScreenState();
}

class _AbilityScreenState extends State<AbilityScreen> {
  Map<String, dynamic> _argument = {};
  Map<String, dynamic> _ability = {};

  @override
  void initState() {
    super.initState();
    getFirstData();
  }

  void getFirstData() async {
    _argument = jsonDecode(widget.data) as Map<String, dynamic>;
    await getAbility();
  }

  Future<void> getAbility() async {
    await AbilityRepo.instance
        .show({"user_id": _argument["user_id"].toString()}).then((value) {
      if (value != false) {
        setState(() {
          _ability = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("KEMAMPUAN"),
      ),
      body: _ability.isEmpty ? buildAbilityEmpty() : buildAbility(),
    );
  }

  Widget buildAbilityEmpty() {
    return const PageEmpty();
  }

  Widget buildAbility() {
    return ListView(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      physics: const ScrollPhysics(),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Lari"),
                  Text(
                    _ability['lari'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Renang"),
                  Text(
                    _ability['renang'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jatri"),
                  Text(
                    _ability['jatri'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jatrat"),
                  Text(
                    _ability['jatrat'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pistol"),
                  Text(
                    _ability['pistol'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Push Up"),
                  Text(
                    _ability['push_up'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Sit Up"),
                  Text(
                    _ability['sit_up'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pull Up"),
                  Text(
                    _ability['pull_up'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Shutle Run"),
                  Text(
                    _ability['shutle_run'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
