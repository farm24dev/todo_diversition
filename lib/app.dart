import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_diversition/presentations/home/providers/todo_list_provider.dart';
import 'package:todo_diversition/presentations/landing/pages/landing_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
    );
  }
}
