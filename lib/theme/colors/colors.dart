import 'package:flutter/material.dart';

const Color imdbYellowColor = Color.fromRGBO(230, 185, 30, 1);
const Color darkColor = Color.fromRGBO(22, 27, 34, 1);
const Color darkestColor = Color.fromRGBO(13, 17, 23, 1);
const Color purpleColor = Color(0xFF8D9EFF);

MaterialColor imdbYellowColorM = createMaterialColor(0xEEE6B91E, 230, 185, 30);

MaterialColor createMaterialColor(int hexCode, int r, int g, int b) {
  return MaterialColor(hexCode, <int, Color>{
    50: Color.fromRGBO(r, g, b, .1),
    100: Color.fromRGBO(r, g, b, .2),
    200: Color.fromRGBO(r, g, b, .3),
    300: Color.fromRGBO(r, g, b, .4),
    400: Color.fromRGBO(r, g, b, .5),
    500: Color.fromRGBO(r, g, b, .6),
    600: Color.fromRGBO(r, g, b, .7),
    700: Color.fromRGBO(r, g, b, .8),
    800: Color.fromRGBO(r, g, b, .9),
    900: Color.fromRGBO(r, g, b, 1),
  });
}
