import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bloc/bloc.dart';
import 'package:todo_app/layout/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppCubit>(
          create: (context) {
            return AppCubit();
          },
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        home: HomePage(),
      ),
    );
  }
}
