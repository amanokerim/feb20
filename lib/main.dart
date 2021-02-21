import 'package:feb20/screens/tasklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/tasklist_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasklistCubit()..getTasks(),
      child: MaterialApp(
        title: 'Task List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
          ),
        ),
        home: TasklistScreen(),
      ),
    );
  }
}
