import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/colours.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'NotoSans';
  static const double _fontSize = 14.0;
  static const FontWeight _fontWeight = FontWeight.normal;

  static const TextStyle regular = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSize,
    fontWeight: _fontWeight,
    color: Colours.black,
  );

  static const TextStyle medium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSize,
    fontWeight: FontWeight.w500,
    color: Colours.black,
  );

  static const TextStyle bold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSize,
    fontWeight: FontWeight.bold,
    color: Colours.black,
  );
}
