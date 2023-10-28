import 'package:flutter/material.dart';

MaterialColor myColor(Color color) {
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
const Color primeColorDark=  Color(0xffFFD500);
const Color secondColorDark=   Color(0xff0F1020);
const Color primeColorLight=  Color(0xff635b85);
const Color secondColorLight=   Color(0xffEDF2F4);
const Color whiteColor=   Color(0xffffffff);
const Color greyColor=    Color(0xff2E3542);
const Color greyColor2=    Colors.grey;
const Color blackColor= Color(0xff000000);