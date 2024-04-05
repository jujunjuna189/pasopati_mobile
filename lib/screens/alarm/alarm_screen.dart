import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/model/alarm_description_model.dart';
import 'package:pro_mobile/utils/colors.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  List<Map<String, dynamic>> alarmList =
      AlarmDescriptionModel.instance.alarmDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("ALARM STELLING"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        physics: const ScrollPhysics(),
        children: [
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 5,
            runSpacing: 10,
            children: alarmList
                .asMap()
                .map((index, value) => MapEntry(
                      index,
                      GestureDetector(
                        onTap: (() {
                          Navigator.of(context).pushNamed("/alarm_board",
                              arguments: jsonEncode(
                                  {"title": value['title'], "code": index}));
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          width: MediaQuery.of(context).size.width * 0.44,
                          decoration: BoxDecoration(
                            color: bgWhite,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset(
                                      "assets/images/icon/alarm.png")),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                value['title'].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                value['sub_title'].toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .values
                .toList(),
          ),
        ],
      ),
    );
  }
}
