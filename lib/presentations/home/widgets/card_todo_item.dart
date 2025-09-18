import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/colours.dart';
import 'package:todo_diversition/data/models/todo_response_entity/todo_response_entity.dart';

class CardTodoItem extends StatelessWidget {
  const CardTodoItem({super.key, this.todo});
  final TodoModel? todo;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 60,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Colours.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Expanded(child: Text(todo?.title ?? '')),
      ],
    );
  }
}
