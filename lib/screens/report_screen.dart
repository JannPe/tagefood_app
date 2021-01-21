import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/ReportPie.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({this.dataMapSpecificDays});

  final Map dataMapSpecificDays;

  String getFromDate() {
    List dates = dataMapSpecificDays.keys.toList();
    DateTime maxDate = dates[0];
    dates.forEach((date) {
      if (date.isAfter(maxDate)) {
        maxDate = date;
      }
    });
    return '${maxDate.day}.${maxDate.month}.${maxDate.year}';
  }

  String getToDate() {
    List dates = dataMapSpecificDays.keys.toList();
    DateTime minDate = dates[0];
    dates.forEach((date) {
      if (date.isBefore(minDate)) {
        minDate = date;
      }
    });
    return '${minDate.day}.${minDate.month}.${minDate.year}';
  }

  Map countFoodAppearancesTotal() {
    Map<String, double> countedFoodTotal = {
      'none': 0,
      'vegan': 0,
      'veggie': 0,
      'fish': 0,
      'chicken': 0,
      'pig': 0,
      'cow': 0
    };

    dataMapSpecificDays.forEach((key, value) {
      value.forEach((key, value) {
        if (value != '') {
          countedFoodTotal[value]++;
        }
      });
    });
    return countedFoodTotal;
  }

  Map countFoodAppearancesBreakfast() {
    Map<String, double> countedFoodBreakfast = {
      'none': 0,
      'vegan': 0,
      'veggie': 0,
      'fish': 0,
      'chicken': 0,
      'pig': 0,
      'cow': 0
    };

    dataMapSpecificDays.forEach((key, value) {
      value.forEach((key, value) {
        if (key == 'Breakfast' && value != '') {
          countedFoodBreakfast[value]++;
        }
      });
    });
    return countedFoodBreakfast;
  }

  Map countFoodAppearancesLunch() {
    Map<String, double> countedFoodLunch = {
      'none': 0,
      'vegan': 0,
      'veggie': 0,
      'fish': 0,
      'chicken': 0,
      'pig': 0,
      'cow': 0
    };

    dataMapSpecificDays.forEach((key, value) {
      value.forEach((key, value) {
        if (key == 'Lunch' && value != '') {
          countedFoodLunch[value]++;
        }
      });
    });
    return countedFoodLunch;
  }

  Map countFoodAppearancesDinner() {
    Map<String, double> countedFoodDinner = {
      'none': 0,
      'vegan': 0,
      'veggie': 0,
      'fish': 0,
      'chicken': 0,
      'pig': 0,
      'cow': 0
    };

    dataMapSpecificDays.forEach((key, value) {
      value.forEach((key, value) {
        if (key == 'Dinner' && value != '') {
          countedFoodDinner[value]++;
        }
      });
    });
    return countedFoodDinner;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Your Stats: ${getFromDate()} - ${getToDate()}',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 30.0),
              ),
              ReportPie(
                countedFood: countFoodAppearancesTotal(),
                size: 110.0,
                badges: true,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50.0,
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'Breakfast',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                ReportPie(
                  countedFood: countFoodAppearancesBreakfast(),
                  size: 70.0,
                  badges: false,
                ),
                SizedBox(
                  width: 5.0,
                ),
                ReportPie(
                    countedFood: countFoodAppearancesDinner(),
                    size: 70.0,
                    badges: false),
                RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Dinner',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: ReportPie(
              countedFood: countFoodAppearancesLunch(),
              size: 70.0,
              badges: false),
        ),
        Text(
          'Lunch',
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    );
  }
}
