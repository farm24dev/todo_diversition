import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_diversition/data/models/todo_response_entity/todo_response_entity.dart';
import 'package:todo_diversition/data/repositories/todo_repository.dart';

part 'get_todo_list_event.dart';
part 'get_todo_list_state.dart';

class GetTodoListBloc extends Bloc<GetTodoListEvent, GetTodoListState> {
  final TodoRepository _repository;
  GetTodoListBloc({required TodoRepository repository})
    : _repository = repository,
      super(GetTodoListInitial()) {
    on<GetTodoListRequestEvent>(_onGetTodoListRequestEvent);
  }

  FutureOr<void> _onGetTodoListRequestEvent(
    GetTodoListRequestEvent event,
    Emitter<GetTodoListState> emit,
  ) async {
    emit(GetTodoListLoading());
    try {
      final response = await _repository.getTodoList();
      if (response.success == true) {
        emit(GetTodoListSuccess(todos: response.data ?? []));
      } else {
        emit(
          GetTodoListFailure(
            message: response.message ?? 'Something went wrong',
          ),
        );
      }
    } catch (e) {
      emit(GetTodoListFailure());
    }
  }
}
