import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo_diversition/data/models/api_response_entity/api_response_entity.dart';
import 'package:todo_diversition/data/models/todo_response_entity/todo_response_entity.dart';

class TodoRepository {
  TodoRepository({required Dio dio}) : _dio = dio;
  final Dio _dio;

  Future<TodoResponseEntity> getTodoList() async {
    try {
      final response = await _dio.get('/api/v1/todos');
      if (response.statusCode == 200) {
        return TodoResponseEntity.fromJson(response.data);
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  Future<ApiResponseEntity> addTodo(Map<String, dynamic> todo) async {
    try {
      final response = await _dio.post('/api/v1/todos', data: todo);
      if (response.statusCode == 200) {
        return ApiResponseEntity.fromJson(response.data);
      } else {
        log('add todo response -> ${response.data}');
        throw Exception('Failed to add todo');
      }
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  Future<ApiResponseEntity> updateTodo(
    String id,
    Map<String, dynamic> todo,
  ) async {
    try {
      final response = await _dio.put('/api/v1/todos/$id', data: todo);
      if (response.statusCode == 200) {
        return ApiResponseEntity.fromJson(response.data);
      } else {
        throw Exception('Failed to update todo');
      }
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  Future<ApiResponseEntity> deleteTodo(String id) async {
    try {
      final response = await _dio.delete('/api/v1/todos/$id');
      if (response.statusCode == 200) {
        return ApiResponseEntity.fromJson(response.data);
      } else {
        throw Exception('Failed to delete todo');
      }
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }
}
