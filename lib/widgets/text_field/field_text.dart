import 'package:flutter/material.dart';
import 'package:pro_mobile/utils/colors.dart';

class FieldText extends StatelessWidget {
  final TextEditingController? controller;
  final double? padding;
  final String? placeHolder;
  final bool border;
  const FieldText(
      {Key? key,
      this.controller,
      this.padding,
      this.placeHolder,
      this.border = true})
      : super(key: key);

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
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: placeHolder ?? '',
          hintStyle: const TextStyle(fontSize: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
