import 'package:flutter/material.dart';
import 'package:pro_mobile/utils/colors.dart';

class ButtonSubmit extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final Color? color;
  const ButtonSubmit(
      {Key? key,
      this.onPressed,
      required this.text,
      this.textColor,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() {
        onPressed!();
      }),
      style: ElevatedButton.styleFrom(
        primary: color ?? bgDanger,
        onPrimary: textColor ?? Colors.white,
        minimumSize: const Size.fromHeight(50),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
