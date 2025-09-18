import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_diversition/constants/apis.dart';
import 'package:todo_diversition/data/repositories/todo_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  final String baseUrl = Apis.baseUrl;

  // ✅ Register Dio (global instance)
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // ➕ สามารถเพิ่ม Interceptor ได้
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('📦 [Dio] Request => ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('✅ [Dio] Response => ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('❌ [Dio] Error => ${e.message}');
          return handler.next(e);
        },
      ),
    );

    return dio;
  });

  // ✅ Register TodoRepository โดยดึง Dio จาก locator
  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepository(dio: locator<Dio>()),
  );
}
