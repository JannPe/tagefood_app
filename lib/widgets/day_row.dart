import 'package:flutter/material.dart';

class DayRow extends StatelessWidget {
  DayRow({this.dataMap, this.day});

  final dataMap;
  final day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: day == 'Sat' || day == 'Sun'
                  ? TextStyle(
                      fontSize: 30.0,
                      color: Colors.blueGrey[300],
                      fontFamily: 'Kalam')
                  : TextStyle(
                      fontSize: 30.0,
                      color: Colors.blueGrey,
                      fontFamily: 'Kalam'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/${dataMap['todayB']}.png',
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 5.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent,
                        width: 30.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Image.asset(
                    'assets/${dataMap['todayL']}.png',
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 5.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent,
                        width: 30.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Image.asset(
                    'assets/${dataMap['todayD']}.png',
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 2.0,
          color: Colors.grey[200],
        ),
      ],
    );
  }
}
