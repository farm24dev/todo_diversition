import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_diversition/constants/app_text_styles.dart';
import 'package:todo_diversition/constants/colours.dart';
import 'package:todo_diversition/presentations/home/blocs/get_todo_list_bloc/get_todo_list_bloc.dart';
import 'package:todo_diversition/presentations/home/pages/add_task_page.dart';
import 'package:todo_diversition/presentations/home/providers/todo_list_provider.dart';
import 'package:todo_diversition/presentations/home/widgets/todo_list.dart';
import 'package:todo_diversition/utils/date_helper.dart';
import 'package:todo_diversition/widgets/button_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    final today = DateTime.now();
    final dateOnly = DateTime(today.year, today.month, today.day);
    context.read<GetTodoListBloc>().add(
      GetTodoListRequestEvent(date: dateOnly.millisecondsSinceEpoch),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          SafeArea(child: SizedBox.shrink()),
          Center(child: Image.asset('assets/images/img_logo.png', height: 40)),
          Center(
            child: Text(
              'Application Todo List',
              style: AppTextStyles.medium.copyWith(fontSize: 20),
            ),
          ),

          Consumer<TodoListProvider>(
            builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTaskPage(),
                              ),
                            ).then((value) {
                              log('Back from AddTaskPage value -> $value');

                              if (value == true) {
                                final selectedDate =
                                    provider.selectedDateTimeline;
                                final dateOnly = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                );
                                context.read<GetTodoListBloc>().add(
                                  GetTodoListRequestEvent(
                                    date: dateOnly.millisecondsSinceEpoch,
                                  ),
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                DatePicker(
                  DateTime.now(),
                  height: 80,
                  width: 55,
                  initialSelectedDate: provider.selectedDateTimeline,
                  selectionColor: Colours.primary,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    provider.updateSelectedDateTimeline(date);
                    final dateOnly = DateTime(date.year, date.month, date.day);
                    context.read<GetTodoListBloc>().add(
                      GetTodoListRequestEvent(
                        date: dateOnly.millisecondsSinceEpoch,
                      ),
                    );
                  },
                  monthTextStyle: AppTextStyles.regular.copyWith(
                    fontSize: 12,
                    color: Colours.grey,
                  ),
                  dayTextStyle: AppTextStyles.medium,
                  dateTextStyle: AppTextStyles.medium,
                ),
                Divider(
                  color: Colours.primary,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
              ],
            ),
          ),
          Expanded(child: TodoList()),
        ],
      ),
    );
  }
}
