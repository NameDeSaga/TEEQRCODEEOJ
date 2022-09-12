import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyConstant {
  static Color primary = Color.fromARGB(255, 255, 236, 69);
  static Color dark = Colors.black;
  static Color light = Color.fromARGB(255, 252, 244, 175);
  static Color actlve = Color.fromARGB(255, 104, 53, 187);
  static Color white = Colors.white;
  static Color blue = Colors.blue;
  TextStyle h1Style() => TextStyle(
        fontSize: 36,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3ActiveStyle() => TextStyle(
        fontSize: 16,
        color: actlve,
        fontWeight: FontWeight.w500,
      );

  TextStyle h3ButtonStyle() => TextStyle(
        fontSize: 13,
        color: blue,
        fontWeight: FontWeight.w500,
      );
}
