import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_diversition/data/repositories/todo_repository.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  final TodoRepository _repository;
  DeleteTodoBloc({required TodoRepository repository})
    : _repository = repository,
      super(DeleteTodoInitial()) {
    on<DeleteTodoRequestEvent>(_onDeleteTodoRequestEvent);
  }

  Future<void> _onDeleteTodoRequestEvent(event, emit) async {
    try {
      emit(DeleteTodoLoading());
      final response = await _repository.deleteTodo(event.id);
      if (response.success == true) {
        emit(DeleteTodoSuccess());
      } else {
        emit(
          DeleteTodoFailure(
            message: response.message ?? 'Failed to delete todo',
          ),
        );
      }
    } catch (e) {
      log('_onDeleteTodoRequestEvent catch -> $e');
      emit(DeleteTodoFailure());
    }
  }
}
