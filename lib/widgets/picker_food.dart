import 'package:flutter/material.dart';

class PickerFood extends StatelessWidget {
  PickerFood({this.meal});

  final String meal;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/$meal.png',
      height: 20.0,
      fit: BoxFit.cover,
    );
  }
}
