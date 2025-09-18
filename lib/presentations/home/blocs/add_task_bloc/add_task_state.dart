part of 'add_task_bloc.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

final class AddTaskInitial extends AddTaskState {}

final class AddTaskLoading extends AddTaskState {}

final class AddTaskSuccess extends AddTaskState {}

final class AddTaskFailure extends AddTaskState {
  const AddTaskFailure({this.message = 'Something went wrong'});
  final String message;

  @override
  List<Object> get props => [message];
}
