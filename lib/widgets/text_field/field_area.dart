import 'package:flutter/material.dart';
import 'package:pro_mobile/utils/colors.dart';

class FieldArea extends StatelessWidget {
  final TextEditingController? controller;
  final double? padding;
  final String? placeHolder;
  final bool border;
  final Color borderColor;
  const FieldArea(
      {Key? key,
      this.controller,
      this.padding,
      this.placeHolder,
      this.border = true,
      this.borderColor = bgLightPrimary,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
      decoration: BoxDecoration(
        color: bgWhite,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(width: 1, color: borderColor)
      ),
      constraints: const BoxConstraints(minHeight: 10),
      child: TextField(
        controller: controller,
        maxLines: 8,
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
