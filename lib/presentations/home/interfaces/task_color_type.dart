import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/colours.dart';

enum TaskColorType { primary, red, green, blue }

extension TaskColorTypeExtension on TaskColorType {
  Color get color {
    switch (this) {
      case TaskColorType.primary:
        return Colours.primary;
      case TaskColorType.red:
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

  static TaskColorType? fromHexRgb(String? hexRgb) {
    if (hexRgb == null) return null;
    switch (hexRgb.toUpperCase()) {
      case '#F2812D':
        return TaskColorType.primary;
      case '#D32F2F':
        return TaskColorType.red;
      case '#388E3C':
        return TaskColorType.green;
      case '#1976D2':
        return TaskColorType.blue;
      default:
        return TaskColorType.primary; // Default to primary if not matched
    }
  }
}
