import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_diversition/presentations/home/interfaces/task_color_type.dart';

class TodoListProvider extends ChangeNotifier {
  DateTime _selectedDateTimeline = DateTime.now();
  DateTime get selectedDateTimeline => _selectedDateTimeline;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  TaskColorType _selectedColor = TaskColorType.primary;
  TaskColorType get selectedColor => _selectedColor;

  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  final TextEditingController _noteController = TextEditingController();
  TextEditingController get noteController => _noteController;

  TimeOfDay? _startTime;
  TimeOfDay? get startTime => _startTime;

  TimeOfDay? _endTime;
  TimeOfDay? get endTime => _endTime;

  void updateSelectedDate(DateTime date) {
    log('updateSelectedDate -> $date');
    _selectedDate = date;
    notifyListeners();
  }

  void updateSelectedColor(TaskColorType color) {
    log('updateSelectedColor -> $color');
    _selectedColor = color;
    notifyListeners();
  }

  void updateSelectedStartTime(BuildContext context, TimeOfDay selected) {
    log('updateSelectedStartTime -> $selected');
    _startTime = selected;
    _endTime = null;
    notifyListeners();
  }

  void updateSelectedEndTime(BuildContext context, TimeOfDay selected) {
    log('updateSelectedEndTime -> $selected');
    _endTime = selected;
    notifyListeners();
  }

  Map<String, dynamic> requestFormData() {
    log('requestFormData');
    final data = {
      'title': _titleController.text,
      'note': _noteController.text,
      'date': _selectedDate.millisecondsSinceEpoch,
      'startTime': DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _startTime?.hour ?? 0,
        _startTime?.minute ?? 0,
      ).millisecondsSinceEpoch,
      'endTime': DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _endTime?.hour ?? 0,
        _endTime?.minute ?? 0,
      ).millisecondsSinceEpoch,
      'color': _selectedColor.hexRgb,
    };

    log('data -> ${json.encode(data)}');

    return data;
  }

  void initialize() {
    log('initialize');
    _selectedDate = _selectedDateTimeline;
    notifyListeners();
  }

  void updateSelectedDateTimeline(DateTime date) {
    log('updateSelectedDateTimeline -> $date');
    _selectedDateTimeline = date;
    notifyListeners();
  }

  void clear() {
    log('clear');
    _selectedDate = DateTime.now();
    _selectedColor = TaskColorType.primary;
    _titleController.clear();
    _noteController.clear();
    _startTime = null;
    _endTime = null;
  }
}
