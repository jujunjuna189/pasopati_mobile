import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_mobile/repository/calendar_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String _dateSelected = "";
  List _eventCalendar = [];

  void getEvent(DateTime selectedDay) async {
    String date = DateFormat("yyyy-MM-dd").format(selectedDay);
    _dateSelected = date;

    Map<String, dynamic> body = {
      "tanggal": date,
    };

    await CalendarRepo.instance.show(body).then((value) {
      _eventCalendar = value;
    });
    setState(() {});
  }

  Color colorSwitch(String color) {
    Color colorSwitch;
    switch (color) {
      case "success":
        colorSwitch = Colors.green;
        break;
      case "primary":
        colorSwitch = Colors.blue;
        break;
      case "danger":
        colorSwitch = Colors.red;
        break;
      case "warning":
        colorSwitch = Colors.orange;
        break;
      case "dark":
        colorSwitch = Colors.black54;
        break;
      default:
        colorSwitch = Colors.red;
    }

    return colorSwitch;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: bgWhite, borderRadius: BorderRadius.circular(10)),
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: (selectedDay, focusedDay) {
                getEvent(selectedDay);
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
            ),
          ),
        ),
        _dateSelected != ""
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "List Event $_dateSelected",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _eventCalendar.isNotEmpty
                          ? Column(
                              children: _eventCalendar.map((value) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: colorSwitch(
                                            value['color'].toString()),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Text(value['event'] ?? ''))
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text("Tidak ada hari peringatan"))
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
