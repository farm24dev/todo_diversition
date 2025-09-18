import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/colours.dart';

enum TaskStatusType { todo, done, unknown }

extension TaskStatusTypeExtension on TaskStatusType {
  static TaskStatusType fromString(String? value) {
    if (value == null) return TaskStatusType.unknown;
    switch (value.toLowerCase()) {
      case 'todo':
        return TaskStatusType.todo;
      case 'done':
        return TaskStatusType.done;
      default:
        return TaskStatusType.unknown;
    }
  }

  String get name {
    switch (this) {
      case TaskStatusType.todo:
        return 'To Do';
      case TaskStatusType.done:
        return 'Done';
      case TaskStatusType.unknown:
        return 'Unknown';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatusType.todo:
        return Colours.blue;
      case TaskStatusType.done:
        return Colours.green;
      case TaskStatusType.unknown:
        return Colours.grey;
    }
  }
}
