import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_diversition/constants/colours.dart';
import 'package:todo_diversition/core/locator.dart';
import 'package:todo_diversition/data/models/todo_response_entity/todo_response_entity.dart';
import 'package:todo_diversition/data/repositories/todo_repository.dart';
import 'package:todo_diversition/presentations/home/blocs/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:todo_diversition/presentations/home/blocs/update_todo_bloc/update_todo_bloc.dart';
import 'package:todo_diversition/widgets/button_custom.dart';
import 'package:todo_diversition/widgets/dialogs/app_dialogs.dart';
import 'package:todo_diversition/widgets/dialogs/loading_dialog.dart';

class ActionTaskModal {
  ActionTaskModal._();

  static Future<String?> show(BuildContext context, {TodoModel? todo}) async {
    return await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colours.white,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<DeleteTodoBloc>(
              create: (context) =>
                  DeleteTodoBloc(repository: locator<TodoRepository>()),
            ),
            BlocProvider<UpdateTodoBloc>(
              create: (context) =>
                  UpdateTodoBloc(repository: locator<TodoRepository>()),
            ),
          ],
          child: _ActionTaskModalContent(todo: todo),
        );
      },
    );
  }
}

class _ActionTaskModalContent extends StatelessWidget {
  const _ActionTaskModalContent({required this.todo});

  final TodoModel? todo;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteTodoBloc, DeleteTodoState>(
          listener: (context, state) async {
            switch (state) {
              case DeleteTodoInitial():
                break;
              case DeleteTodoLoading():
                LoadingDialog.show(context);
                break;
              case DeleteTodoSuccess():
                LoadingDialog.hide(context);
                await AppDialogs.success(context, message: 'ลบข้อมูลสำเร็จ');
                Navigator.pop(context, 'success');
                break;
              case DeleteTodoFailure():
                LoadingDialog.hide(context);
                await AppDialogs.error(context, message: state.message);
                break;
            }
          },
        ),
        BlocListener<UpdateTodoBloc, UpdateTodoState>(
          listener: (context, state) async {
            switch (state) {
              case UpdateTodoInitial():
                break;
              case UpdateTodoLoading():
                LoadingDialog.show(context);
                break;
              case UpdateTodoSuccess():
                LoadingDialog.hide(context);
                await AppDialogs.success(
                  context,
                  message: 'บันทึกข้อมูลสำเร็จ',
                );
                Navigator.pop(context, 'success');
                break;
              case UpdateTodoFailure():
                LoadingDialog.hide(context);
                await AppDialogs.error(context, message: state.message);
                break;
            }
          },
        ),
      ],
      child: _buildModalContent(context),
    );
  }

  Widget _buildModalContent(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Center(
            child: Container(
              width: 80,
              height: 5,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colours.grey.withOpacity(0.5),
              ),
            ),
          ),
          SizedBox.shrink(),
          ButtonCustom(
            height: 40,
            width: double.infinity,
            text: 'Task Done',
            backgroundColor: Colours.primary.withOpacity(0.7),
            onPressed: () async {
              bool? isConfirm = await AppDialogs.confirm(
                message: 'ต้องการบันทึกข้อมูลใช่หรือไม่?',
                context,
              );
              if (isConfirm == null || !isConfirm) return;

              final Map<String, dynamic> updateData = {'status': 'done'};
              context.read<UpdateTodoBloc>().add(
                UpdateTodoRequestEvent(id: todo?.id ?? '', data: updateData),
              );
            },
          ),
          ButtonCustom(
            height: 40,
            width: double.infinity,
            text: 'Delete Task',
            backgroundColor: Colours.red.withOpacity(0.7),
            onPressed: () async {
              bool? isConfirm = await AppDialogs.confirm(
                message: 'ต้องการลบข้อมูลใช่หรือไม่?',
                context,
                title: 'Confirm Delete',
              );

              if (isConfirm == null || !isConfirm) return;

              context.read<DeleteTodoBloc>().add(
                DeleteTodoRequestEvent(id: todo?.id ?? ''),
              );
            },
          ),
          SizedBox.shrink(),
        ],
      ),
    );
  }
}
