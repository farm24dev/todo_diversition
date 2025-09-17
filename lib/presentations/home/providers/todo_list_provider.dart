import 'package:flutter/material.dart';

class TodoListProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
}
