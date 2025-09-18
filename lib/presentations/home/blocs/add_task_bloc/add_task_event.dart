part of 'add_task_bloc.dart';

sealed class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskRequestEvent extends AddTaskEvent {
  const AddTaskRequestEvent({required this.data});

  final Map<String, dynamic> data;

  @override
  List<Object> get props => [data];
}
