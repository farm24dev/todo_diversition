part of 'update_todo_bloc.dart';

sealed class UpdateTodoEvent extends Equatable {
  const UpdateTodoEvent();

  @override
  List<Object> get props => [];
}

class UpdateTodoRequestEvent extends UpdateTodoEvent {
  const UpdateTodoRequestEvent({required this.id, required this.data});
  final String id;
  final Map<String, dynamic> data;
  @override
  List<Object> get props => [id, data];
}
