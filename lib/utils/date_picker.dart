import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/colours.dart';

class DatePickerHelper {
  static Future<DateTime?> show(
    BuildContext context, {
    bool? isNolastDate = false,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colours.primary, // Orange color
              onPrimary: Colours.white,
              surface: Colours.white,
              onSurface: Colours.black,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colours.white,
              headerBackgroundColor: Colours.primary,
              headerForegroundColor: Colours.white,
              dayForegroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colours.white;
                }
                return Colours.black;
              }),
              dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colours.primary;
                }
                return Colors.transparent;
              }),
              todayForegroundColor: MaterialStateProperty.all(Colours.primary),
              todayBackgroundColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
