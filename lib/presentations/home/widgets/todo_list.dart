import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_diversition/constants/app_text_styles.dart';
import 'package:todo_diversition/constants/colours.dart';
import 'package:todo_diversition/presentations/home/blocs/bloc/get_todo_list_bloc.dart';
import 'package:todo_diversition/presentations/home/widgets/card_todo_item.dart';
import 'package:todo_diversition/widgets/loading_widget.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTodoListBloc, GetTodoListState>(
      builder: (context, state) {
        switch (state) {
          case GetTodoListInitial():
          case GetTodoListLoading():
            return const LoadingWidget();
          case GetTodoListFailure():
            return Center(
              child: Text(
                'Failed to load todo list',
                style: AppTextStyles.regular.copyWith(color: Colours.grey),
              ),
            );
          case GetTodoListSuccess():
            if (state.todos.isEmpty) {
              return Center(
                child: Text(
                  'ไม่มีข้อมูล',
                  style: AppTextStyles.regular.copyWith(color: Colours.grey),
                ),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return CardTodoItem(todo: todo);
              },
            );
        }
      },
    );
  }
}
