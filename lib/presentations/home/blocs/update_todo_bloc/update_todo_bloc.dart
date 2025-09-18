import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_diversition/data/repositories/todo_repository.dart';

part 'update_todo_event.dart';
part 'update_todo_state.dart';

class UpdateTodoBloc extends Bloc<UpdateTodoEvent, UpdateTodoState> {
  final TodoRepository _repository;
  UpdateTodoBloc({required TodoRepository repository})
    : _repository = repository,
      super(UpdateTodoInitial()) {
    on<UpdateTodoRequestEvent>(_onUpdateTodoRequestEvent);
  }

  Future<void> _onUpdateTodoRequestEvent(
    UpdateTodoRequestEvent event,
    Emitter<UpdateTodoState> emit,
  ) async {
    try {
      emit(UpdateTodoLoading());
      final response = await _repository.updateTodo(event.id, event.data);
      if (response.success == true) {
        emit(UpdateTodoSuccess());
      } else {
        emit(
          UpdateTodoFailure(
            message: response.message ?? 'Failed to delete todo',
          ),
        );
      }
    } catch (e) {
      log('_onUpdateTodoRequestEvent catch -> $e');
      emit(UpdateTodoFailure());
    }
  }
}
