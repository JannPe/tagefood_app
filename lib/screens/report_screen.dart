import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({this.food, this.dataMap});

  List<String> food;
  var dataMap;

  List<Image> getFoodsInReports() {
    List<Image> foodImages = [];
    food.forEach((foodElement) {
      foodImages.add(
        Image.asset(
          'assets/$foodElement.png',
          height: 100.0,
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