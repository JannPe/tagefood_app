import 'package:flutter/material.dart';

class DayRow extends StatelessWidget {
  DayRow({this.dataMap, this.day});

  final dataMap;
  final day;

  @override
  Widget build(BuildContext context) {
    print('day row $dataMap');
    print('day row todayB ${dataMap['todayB']}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: TextStyle(fontSize: 30.0),
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
    );
  }
}
