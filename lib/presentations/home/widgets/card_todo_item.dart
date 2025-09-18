import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/app_text_styles.dart';
import 'package:todo_diversition/constants/colours.dart';
import 'package:todo_diversition/data/models/todo_response_entity/todo_response_entity.dart';
import 'package:todo_diversition/presentations/home/interfaces/task_color_type.dart';
import 'package:todo_diversition/presentations/home/interfaces/task_status_type.dart';
import 'package:todo_diversition/utils/date_helper.dart';

class CardTodoItem extends StatelessWidget {
  const CardTodoItem({super.key, this.todo, this.onTap});
  final TodoModel? todo;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final todoColor =
        TaskColorTypeExtension.fromHexRgb(todo?.color)?.color ?? Colours.grey;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 8, right: 16, top: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Colours.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: todoColor.withOpacity(0.24),

              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 80,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: todoColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          todo?.title ?? '',
                          style: AppTextStyles.medium.copyWith(fontSize: 16),
                        ),
                      ),
                      _buildCardStatus(),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colours.grey),
                      Expanded(
                        child: Text(
                          '${DateHelper.time(todo?.startTime)} - ${DateHelper.time(todo?.endTime)}',
                          style: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: Colours.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    todo?.note ?? '',
                    style: AppTextStyles.regular.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCardStatus() {
    final todoStatusColor = TaskStatusTypeExtension.fromString(
      todo?.status,
    ).color;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: todoStatusColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        TaskStatusTypeExtension.fromString(
          todo?.status,
        ).name.toUpperCase().replaceAll(' ', ''),
        style: AppTextStyles.medium.copyWith(
          fontSize: 12,
          color: Colours.white,
        ),
      ),
    );
  }
}
