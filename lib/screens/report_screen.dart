import 'package:flutter/material.dart';
import '../widgets/ReportPie.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({this.dataMapSpecificSevenDays});

  final Map dataMapSpecificSevenDays;

  Map countFoodAppearances() {
    Map<String, double> countedFoodLastSevenDays = {
      'none': 0,
      'vegan': 0,
      'veggie': 0,
      'fish': 0,
      'chicken': 0,
      'pig': 0,
      'cow': 0
    };

    dataMapSpecificSevenDays.forEach((key, value) {
      value.forEach((key, value) {
        switch (value) {
          case 'none':
            {
              countedFoodLastSevenDays['none']++;
            }
            break;

          case 'vegan':
            {
              countedFoodLastSevenDays['vegan']++;
            }
            break;

          case 'veggie':
            {
              countedFoodLastSevenDays['veggie']++;
            }
            break;

          case 'fish':
            {
              countedFoodLastSevenDays['fish']++;
            }
            break;

          case 'chicken':
            {
              countedFoodLastSevenDays['chicken']++;
            }
            break;
          case 'pig':
            {
              countedFoodLastSevenDays['pig']++;
            }
            break;
          case 'cow':
            {
              countedFoodLastSevenDays['cow']++;
            }
            break;
          case '':
            {}
            break;

          default:
            {}
            break;
        }
      });
    });
    print('countedMealsLastSevenDays $countedFoodLastSevenDays');
    return countedFoodLastSevenDays;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReportPie(countedFood: countFoodAppearances()),
        ReportPie(countedFood: countFoodAppearances()),
      ],
    );
  }
}
