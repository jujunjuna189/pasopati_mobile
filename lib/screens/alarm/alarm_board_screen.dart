import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/firebase/fire_alarm_repo.dart';
import 'package:pro_mobile/utils/colors.dart';

class AlarmBoardScreen extends StatefulWidget {
  const AlarmBoardScreen({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  State<AlarmBoardScreen> createState() => _AlarmBoardScreenState();
}

class _AlarmBoardScreenState extends State<AlarmBoardScreen> {
  Map<String, dynamic> _dataAlarm = {};
  Duration _duration = const Duration();
  Timer? _timer;
  bool _isRunning = true;

  @override
  void initState() {
    _dataAlarm = jsonDecode(widget.data) as Map<String, dynamic>;
    super.initState();
  }

  void onRinging() {
    // Timer
    _isRunning = _timer == null ? false : _timer!.isActive;
    if (_isRunning) {
      stopTimer();
      pushRinging(status: false);
    } else {
      startTimer();
      pushRinging(status: true);
    }
  }

  void pushRinging({bool status = false}) async {
    Map<String, dynamic> dataBatch = {
      "status": status,
      "alarm": _dataAlarm["title"] ?? "",
      "code": _dataAlarm["code"] ?? ""
    };

    //Firebase Push
    FireAlarmRepo.instance.store(dataBatch);
  }

  void stopTimer() {
    setState(() {
      _timer?.cancel();
    });
  }

  void addTime() {
    const addSeconds = 1;
    final seconds = _duration.inSeconds + addSeconds;
    _duration = Duration(seconds: seconds);
  }

  void startTimer() {
    _duration = const Duration();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      addTime();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(_dataAlarm["title"] ?? "Alarm"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$hours:$minutes:$seconds",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
                onTap: (() {
                  onRinging();
                }),
                child: _isRunning
                    ? const Icon(
                        Icons.play_circle_fill,
                        color: textDanger,
                        size: 100,
                      )
                    : const Icon(
                        Icons.pause_circle_filled,
                        color: textDanger,
                        size: 100,
                      )),
          ],
        ),
      ),
    );
  }
}
