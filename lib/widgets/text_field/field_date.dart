import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/utils/format.dart';

class FieldDate extends StatelessWidget {
  final TextEditingController? controller;
  final double? padding;
  final String? placeHolder;
  final bool border;
  const FieldDate(
      {Key? key,
      this.controller,
      this.padding,
      this.placeHolder,
      this.border = true})
      : super(key: key);

  void getDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            1900), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));
    DateFormat dateFormat = DateFormat(Format.dateFormat);
    if (pickedDate != null) {
      controller!.text = dateFormat.format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
      decoration: BoxDecoration(
        color: bgWhite,
        border: Border(
            bottom: BorderSide(
                width: 1, color: border ? bgLightPrimary : Colors.transparent)),
      ),
      constraints: const BoxConstraints(minHeight: 10),
      child: TextField(
        controller: controller,
        readOnly: true,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
            hintText: placeHolder ?? '',
            hintStyle: const TextStyle(fontSize: 16),
            border: InputBorder.none,
            suffixIcon: const Icon(
              Icons.calendar_month,
              size: 20,
              color: textSoftLight,
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 25,
              minHeight: 25,
            )),
        onTap: (() async {
          getDatePicker(context);
        }),
      ),
    );
  }
}
