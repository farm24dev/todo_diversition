import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/colours.dart';

class TimePickerHelper {
  static Future<TimeOfDay?> show(
    BuildContext context, {
    bool? isNolastDate = false,
    TimeOfDay? initialTime,
  }) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colours.primary, // Orange color
              onPrimary: Colours.white,
              surface: Colours.white,
              onSurface: Colours.black,
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colours.white,
              hourMinuteTextColor: Colours.black,
              dayPeriodTextColor: Colours.black,
              dialHandColor: Colours.primary,
              dialBackgroundColor: Colours.primary.withOpacity(0.1),
              hourMinuteColor: Colours.primary.withOpacity(0.1),
              dayPeriodColor: Colours.primary.withOpacity(0.1),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
