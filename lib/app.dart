import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_diversition/core/locator.dart';
import 'package:todo_diversition/data/repositories/todo_repository.dart';
import 'package:todo_diversition/presentations/home/blocs/get_todo_list_bloc/get_todo_list_bloc.dart';
import 'package:todo_diversition/presentations/home/providers/todo_list_provider.dart';
import 'package:todo_diversition/presentations/landing/pages/landing_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetTodoListBloc(repository: locator<TodoRepository>()),
      child: ChangeNotifierProvider(
        create: (context) => TodoListProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'NotoSans',
          ),
          home: const LandingPage(),
        ),
      ),
    );
  }
}
