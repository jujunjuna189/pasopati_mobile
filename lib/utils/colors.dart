import 'dart:ui';

import 'package:flutter/material.dart';

//Background
const bgPrimary = Color(0xFF1C1C1C);
const bgLightPrimary = Color(0xFFD5D5D5);
const bgSuccess = Color(0xFF09830D);
const bgLightTransparent = Color(0xAED5D5D5);
const bgLightTransparentHight = Color(0xFFF3F3F3);
const bgDanger = Color(0xFF5D0909);
const bgWhite = Color(0xFFFFFFFF);
const bgDark = Color(0xFF171717);
const bgDarkTranparent = Color(0xBE1C1C1C);

//Text
const textPrimary = Color(0xFF2C2C2C);
const textSuccess = Color(0xFF09830D);
const textDanger = Color(0xFF5D0909);
const textWarning = Color(0xFFF1DC00);
const textOrange = Color(0xFFFF8D11);
const textBlue = Color(0xFF0028D5);
const textLight = Color(0xFFFFFFFF);
const textSoftLight = Color(0xFF989898);
const textDark = Color(0xFF171717);

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}