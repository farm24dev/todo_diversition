part of 'get_todo_list_bloc.dart';

sealed class GetTodoListState extends Equatable {
  const GetTodoListState();

  @override
  List<Object> get props => [];
}

final class GetTodoListInitial extends GetTodoListState {}

final class GetTodoListLoading extends GetTodoListState {}

final class GetTodoListSuccess extends GetTodoListState {
  const GetTodoListSuccess({this.todos = const []});
  final List<TodoModel> todos;
  @override
  List<Object> get props => [todos];
}

final class GetTodoListFailure extends GetTodoListState {
  const GetTodoListFailure({this.message = 'Something went wrong'});
  final String message;

  @override
  List<Object> get props => [message];
}
