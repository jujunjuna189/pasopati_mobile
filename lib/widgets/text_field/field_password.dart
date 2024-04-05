import 'package:flutter/material.dart';
import 'package:pro_mobile/utils/colors.dart';

class FieldPassword extends StatefulWidget {
  final TextEditingController? controller;
  final String? placeHolder;
  const FieldPassword({Key? key, this.controller, this.placeHolder})
      : super(key: key);

  @override
  State<FieldPassword> createState() => _FieldPasswordState();
}

class _FieldPasswordState extends State<FieldPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: bgWhite,
        border: Border(bottom: BorderSide(width: 1, color: bgLightPrimary)),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _isObscure,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: const TextStyle(fontSize: 16),
          suffixIcon: GestureDetector(
              onTap: (() {
                setState(() {
                  _isObscure = _isObscure ? false : true;
                });
              }),
              child: _isObscure
                  ? const Icon(
                      Icons.visibility_off,
                      size: 20,
                      color: textDark,
                    )
                  : const Icon(
                      Icons.visibility,
                      size: 20,
                      color: textDark,
                    )),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
