import 'package:flutter/material.dart';

class FoodImage extends StatelessWidget {
  FoodImage({this.meal, this.height});

  final String meal;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/$meal.png',
      height: height,
      fit: BoxFit.cover,
    );
  }
}
