import 'package:flutter/material.dart';

class DayRow extends StatelessWidget {
  DayRow({@required this.dataMap, @required this.day, this.isToday});

  final Map dataMap;
  final day;
  final isToday;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day, //TODO: also display day and month
              style: isToday == true
                  ? TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      fontFamily: 'Kalam')
                  : TextStyle(
                      fontSize: 30.0,
                      color: Colors.blueGrey,
                      fontFamily: 'Kalam'),
            ), //Day
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/${dataMap['Breakfast']}.png',
                    width: 50.0,
                    fit: BoxFit.cover,
                  ), //Breakfast
                  Container(
                    height: 3.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent,
                        width: 25.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ), //green line between Icons
                  Image.asset(
                    'assets/${dataMap['Lunch']}.png',
                    width: 50.0,
                    fit: BoxFit.cover,
                  ), //Lunch
                  Container(
                    height: 3.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent,
                        width: 25.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ), // green line between Icons
                  Image.asset(
                    'assets/${dataMap['Dinner']}.png',
                    width: 50.0,
                    fit: BoxFit.cover,
                  ), //Dinner
                ],
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 2.0,
          color: Colors.grey[200],
        ), //grey Spacing Line in between Rows
      ],
    );
  }
}
