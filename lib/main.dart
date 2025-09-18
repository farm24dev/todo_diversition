import 'package:flutter/material.dart';
import 'package:todo_diversition/app.dart';
import 'package:todo_diversition/core/locator.dart';

Future<void> main() async {
  setupLocator();
  runApp(const MyApp());
}
