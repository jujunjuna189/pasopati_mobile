import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class AlarmDescriptionScreen extends StatefulWidget {
  const AlarmDescriptionScreen({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  State<AlarmDescriptionScreen> createState() => _AlarmDescriptionScreenState();
}

class _AlarmDescriptionScreenState extends State<AlarmDescriptionScreen> {
  Map<String, dynamic> _dataAlarm = {};

  @override
  void initState(){
    _dataAlarm = jsonDecode(widget.data) as Map<String, dynamic>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        color: Colors.white,
        child: RippleAnimation(
          repeat: true,
          color: Colors.red,
          minRadius: 70,
          ripplesCount: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${_dataAlarm["title"] ?? ""}", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
              const SizedBox(height: 50,),
              Text("${_dataAlarm["sub_title"] ?? ""}", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("${_dataAlarm["content"] ?? ""}", style: const TextStyle(fontSize: 15), textAlign: TextAlign.center,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
