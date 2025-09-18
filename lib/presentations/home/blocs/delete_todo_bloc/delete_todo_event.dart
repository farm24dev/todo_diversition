part of 'delete_todo_bloc.dart';

sealed class DeleteTodoEvent extends Equatable {
  const DeleteTodoEvent();

  @override
  List<Object> get props => [];
}

class DeleteTodoRequestEvent extends DeleteTodoEvent {
  const DeleteTodoRequestEvent({required this.id});
  final String id;
  @override
  List<Object> get props => [id];
}
