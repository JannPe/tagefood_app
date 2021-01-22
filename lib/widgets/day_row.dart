import 'package:flutter/material.dart';

class DayRow extends StatelessWidget {
  DayRow(
      {@required this.dataMap,
      @required this.day,
      @required this.date,
      this.isToday});

  final Map dataMap;
  final String day;
  final DateTime date;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: isToday == true
                  ? TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      fontFamily: 'Kalam')
                  : TextStyle(
                      fontSize: 25.0,
                      color: Colors.blueGrey,
                      fontFamily: 'Kalam'),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                '${date.day.toString()}.${date.month.toString()}.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/${dataMap['Breakfast']}.png',
                    width: 40.0,
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
                    width: 40.0,
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
                    width: 40.0,
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
