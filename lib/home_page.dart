import 'package:flutter/material.dart';
import 'package:pomodoro_in_flutter/quizler_main.dart';
import 'package:pomodoro_in_flutter/screens/calculator_screen.dart';
import 'package:pomodoro_in_flutter/timer_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TimerPage()));
                },
                child: Text("Timer Page")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CalculatorScreen()));
                },
                child: Text("Calculator Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizPage()));
                },
                child: Text("Quiz Page")),

          ],
        ),
      ),
    );
  }
}
