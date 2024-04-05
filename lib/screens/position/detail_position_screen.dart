import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/utils/colors.dart';

class DetailPositionScreen extends StatefulWidget {
  const DetailPositionScreen({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  State<DetailPositionScreen> createState() => _DetailPositionScreenState();
}

class _DetailPositionScreenState extends State<DetailPositionScreen> {
  Map<String, dynamic> _argument = {};

  @override
  void initState() {
    _argument = jsonDecode(widget.data) as Map<String, dynamic>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(_argument['title'] ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: bgLightPrimary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        _argument['nama'].toString().substring(0, 2),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Nama"),
                      Text(
                        _argument['nama'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pangkat"),
                  Text(
                    _argument['pangkat'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("NRP"),
                  Text(
                    _argument['nrp'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: const BoxDecoration(
                color: bgWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jabatan"),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      _argument['jabatan'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
