import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({this.food, this.dataMap});

  final List<String> food;
  final dataMap;

  List<Image> getFoodsInReports() {
    List<Image> foodImages = [];
    food.forEach((foodElement) {
      foodImages.add(
        Image.asset(
          'assets/$foodElement.png',
          height: 70.0,
          fit: BoxFit.cover,
        ),
      );
    });
    return foodImages;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: getFoodsInReports(),
      ),
    );
  }
}
