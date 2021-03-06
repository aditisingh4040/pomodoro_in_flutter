import 'package:flutter/material.dart';
import 'package:pomodoro_in_flutter/model_todey/task_data.dart';
import 'package:pomodoro_in_flutter/screens_todey/tasks_screen.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
