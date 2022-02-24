import 'package:flutter/material.dart';
import 'package:pomodoro_in_flutter/home_page.dart';
// Checking
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}



