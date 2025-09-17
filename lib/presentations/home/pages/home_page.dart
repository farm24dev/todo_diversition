import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/app_text_styles.dart';
import 'package:todo_diversition/constants/colours.dart';
import 'package:todo_diversition/utils/date_helper.dart';
import 'package:todo_diversition/widgets/button_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colours.white,
        appBar: AppBar(
          title: Center(
            child: Image.asset('assets/images/img_logo.png', height: 40),
          ),
          backgroundColor: Colours.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Application TODO LIST',
                    style: AppTextStyles.medium.copyWith(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              DateHelper.dateTimeDefault(
                                DateTime.now().millisecondsSinceEpoch,
                              ),
                              style: AppTextStyles.regular.copyWith(
                                fontSize: 12,
                                color: Colours.grey,
                              ),
                            ),
                            Text(
                              'Today',
                              style: AppTextStyles.bold.copyWith(
                                fontSize: 16,
                                color: Colours.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: ButtonCustom(
                          height: 36,
                          text: '+ Add Task',
                          onPressed: () {
                            //todo
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 70,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colours.primary,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    log('onDateChange -> $date');
                  },
                  monthTextStyle: AppTextStyles.regular.copyWith(
                    fontSize: 12,
                    color: Colours.grey,
                  ),
                  dayTextStyle: AppTextStyles.medium,
                  dateTextStyle: AppTextStyles.medium,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [const SizedBox(height: 16)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
