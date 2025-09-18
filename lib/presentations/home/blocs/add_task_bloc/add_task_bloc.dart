import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_diversition/data/repositories/todo_repository.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final TodoRepository _repository;

  AddTaskBloc({required TodoRepository repository})
    : _repository = repository,
      super(AddTaskInitial()) {
    on<AddTaskRequestEvent>(_onAddTaskRequestEvent);
  }

  Future<void> _onAddTaskRequestEvent(
    AddTaskRequestEvent event,
    Emitter<AddTaskState> emit,
  ) async {
    try {
      emit(AddTaskLoading());

      final response = await _repository.addTodo(event.data);
      log('_onAddTaskRequestEvent response -> ${response}');
      emit(AddTaskSuccess());
    } catch (e) {
      log('_onAddTaskRequestEvent catch -> $e');
      emit(AddTaskFailure());
    }
  }
}
