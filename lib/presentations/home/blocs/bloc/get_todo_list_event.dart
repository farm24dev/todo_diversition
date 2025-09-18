part of 'get_todo_list_bloc.dart';

sealed class GetTodoListEvent extends Equatable {
  const GetTodoListEvent();

  @override
  List<Object?> get props => [];
}

class GetTodoListRequestEvent extends GetTodoListEvent {
  const GetTodoListRequestEvent({this.date});
  final int? date;
  @override
  List<Object?> get props => [date];
}
