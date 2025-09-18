import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/colours.dart';

enum TaskColorType { primary, red, green, blue }

extension TaskColorExtension on TaskColorType {
  Color get color {
    switch (this) {
      case TaskColorType.primary:
        return Colours.primary;
      case TaskColorType  .red:
        return Colours.red;
      case TaskColorType.green:
        return Colours.green;
      case TaskColorType.blue:
        return Colours.blue;
    }
  }

  String get hexRgb {
    final rgb = color.value & 0x00FFFFFF;
    return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
