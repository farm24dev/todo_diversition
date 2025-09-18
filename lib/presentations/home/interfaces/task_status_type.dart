import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/colours.dart';

enum TaskStatusType { todo, inprogress, done }

extension TaskColorExtension on TaskStatusType {
  static fromString(String value) {
    switch (value.toLowerCase()) {
      case 'todo':
        return TaskStatusType.todo;
      case 'inprogress':
        return TaskStatusType.inprogress;
      case 'done':
        return TaskStatusType.done;
      default:
        return TaskStatusType.todo;
    }
  }

  String get name {
    switch (this) {
      case TaskStatusType.todo:
        return 'To Do';
      case TaskStatusType.inprogress:
        return 'In Progress';
      case TaskStatusType.done:
        return 'Done';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatusType.todo:
        return Colours.red;
      case TaskStatusType.inprogress:
        return Colours.blue;
      case TaskStatusType.done:
        return Colours.green;
    }
  }
}
