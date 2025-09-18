import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_diversition/constants/app_text_styles.dart';
import 'package:todo_diversition/constants/colours.dart';
import 'package:todo_diversition/core/locator.dart';
import 'package:todo_diversition/data/repositories/todo_repository.dart';
import 'package:todo_diversition/presentations/home/blocs/add_task_bloc/add_task_bloc.dart';
import 'package:todo_diversition/presentations/home/interfaces/task_color_type.dart';
import 'package:todo_diversition/presentations/home/providers/todo_list_provider.dart';
import 'package:todo_diversition/utils/date_helper.dart';
import 'package:todo_diversition/utils/date_picker.dart';
import 'package:todo_diversition/utils/time_picker.dart';
import 'package:todo_diversition/utils/validators.dart';
import 'package:todo_diversition/widgets/button_custom.dart';
import 'package:todo_diversition/widgets/dialogs/app_dialogs.dart';
import 'package:todo_diversition/widgets/dialogs/loading_dialog.dart';
import 'package:todo_diversition/widgets/text_formfield_custom.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late AddTaskBloc addTaskBloc;

  @override
  void initState() {
    super.initState();
    addTaskBloc = AddTaskBloc(repository: locator<TodoRepository>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TodoListProvider>();
      provider.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addTaskBloc,
      child: BlocListener<AddTaskBloc, AddTaskState>(
        bloc: addTaskBloc,
        listener: (context, state) async {
          switch (state) {
            case AddTaskInitial():
              break;
            case AddTaskLoading():
              LoadingDialog.show(context);
              break;
            case AddTaskSuccess():
              LoadingDialog.hide(context);
              await AppDialogs.success(context, message: 'บันทึกข้อมูลสำเร็จ');
              Navigator.pop(context, true);
              context.read<TodoListProvider>().clear();
              break;
            case AddTaskFailure():
              LoadingDialog.hide(context);
              await AppDialogs.error(context, message: state.message);
              break;
          }
        },
        child: _view(context),
      ),
    );
  }

  Scaffold _view(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colours.primary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colours.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Task',
          style: AppTextStyles.medium.copyWith(
            fontSize: 20,
            color: Colours.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colours.black),
      ),
      body: Consumer<TodoListProvider>(
        builder: (context, provider, child) => Form(
          key: provider.formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                _buildTitle(
                  title: 'Title',
                  child: TextFormFieldCustom(
                    hintText: 'title',
                    controller: provider.titleController,
                    validator: Validators.required('required'),
                  ),
                ),
                _buildTitle(
                  title: 'Note',
                  child: TextFormFieldCustom(
                    hintText: 'note',
                    lines: 4,
                    controller: provider.noteController,
                  ),
                ),
                _buildTitle(
                  title: 'Date',
                  child: TextFormFieldCustom(
                    hintText: '',
                    controller: TextEditingController(
                      text: DateHelper.date(
                        provider.selectedDate.millisecondsSinceEpoch,
                      ),
                    ),
                    readOnly: true,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Colours.primary,
                    ),
                    onTap: () async {
                      final selected = await DatePickerHelper.show(
                        context,
                        initialDate: provider.selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                      );
                      if (selected != null) {
                        provider.updateSelectedDate(selected);
                      }
                    },
                    validator: Validators.required('required'),
                  ),
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: _buildTitle(
                        title: 'Start Time',
                        child: TextFormFieldCustom(
                          hintText: '00:00',
                          controller: TextEditingController(
                            text: provider.startTime?.format(context) ?? '',
                          ),
                          readOnly: true,
                          suffixIcon: Icon(
                            Icons.access_time,
                            color: Colours.primary,
                          ),
                          onTap: () async {
                            final selected = await TimePickerHelper.show(
                              context,
                              initialTime: TimeOfDay(hour: 08, minute: 00),
                            );
                            if (selected != null) {
                              // If end time exists, check if new start time is valid
                              if (provider.endTime != null) {
                                final startMinutes =
                                    selected.hour * 60 + selected.minute;
                                final endMinutes =
                                    provider.endTime!.hour * 60 +
                                    provider.endTime!.minute;

                                if (startMinutes >= endMinutes) {
                                  // Show error dialog if start time is not before end time
                                  await AppDialogs.error(
                                    context,
                                    message:
                                        'เวลาเริ่มต้นต้องน้อยกว่าเวลาสิ้นสุด',
                                  );
                                  return;
                                }
                              }
                              provider.updateSelectedStartTime(
                                context,
                                selected,
                              );
                            }
                          },
                          validator: Validators.required('required'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildTitle(
                        title: 'End Time',
                        child: TextFormFieldCustom(
                          hintText: '00:00',
                          controller: TextEditingController(
                            text: provider.endTime?.format(context) ?? '',
                          ),
                          readOnly: true,
                          suffixIcon: Icon(
                            Icons.access_time,
                            color: Colours.primary,
                          ),
                          onTap: () async {
                            final selected = await TimePickerHelper.show(
                              context,
                              initialTime:
                                  provider.startTime ??
                                  TimeOfDay(hour: 08, minute: 00),
                            );
                            if (selected != null) {
                              // Check if end time is after start time
                              if (provider.startTime != null) {
                                final startMinutes =
                                    provider.startTime!.hour * 60 +
                                    provider.startTime!.minute;
                                final endMinutes =
                                    selected.hour * 60 + selected.minute;

                                if (endMinutes <= startMinutes) {
                                  // Show error dialog if end time is not after start time
                                  await AppDialogs.error(
                                    context,
                                    message:
                                        'เวลาสิ้นสุดต้องมากกว่าเวลาเริ่มต้น',
                                  );
                                  return;
                                }
                              }
                              provider.updateSelectedEndTime(context, selected);
                            }
                          },
                          validator: Validators.required('required'),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildTitle(
                  title: 'Color',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(TaskColorType.values.length, (
                      index,
                    ) {
                      final color = TaskColorType.values[index];
                      return _buildTaskColor(
                        color,
                        isSelected: provider.selectedColor == color,
                        onTap: () {
                          provider.updateSelectedColor(color);
                        },
                      );
                    }).toList(),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 16),
                  alignment: Alignment.center,
                  child: ButtonCustom(
                    height: 40,
                    text: 'Create a Task',
                    onPressed: () async {
                      if (provider.formKey.currentState?.validate() != true) {
                        return;
                      }
                      if (!provider.formKey.currentState!.validate()) return;
                      bool? isConfirm = await AppDialogs.confirm(
                        context,
                        message: 'ต้องการบันทึกข้อมูลใช่หรือไม่?',
                      );
                      if (isConfirm == null || !isConfirm) return;
                      final Map<String, dynamic> data = provider
                          .requestFormData();

                      addTaskBloc.add(AddTaskRequestEvent(data: data));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildTaskColor(
    TaskColorType? color, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: color?.color, shape: BoxShape.circle),
        child: isSelected
            ? Icon(Icons.check, color: Colours.white, size: 16)
            : SizedBox.shrink(),
      ),
    );
  }
}

Column _buildTitle({String? title, Widget? child}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 4,
    children: [
      Text(
        title ?? '',
        style: AppTextStyles.bold.copyWith(color: Colours.black),
      ),
      if (child != null) child,
    ],
  );
}
