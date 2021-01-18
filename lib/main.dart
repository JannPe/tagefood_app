import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagefood_app/screens/loading_screen.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoadingScreen(),
    );
  }
}
