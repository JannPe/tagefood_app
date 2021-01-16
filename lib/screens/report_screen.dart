import 'package:flutter/material.dart';
import '../widgets/ReportPie.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({this.dataMapSpecificSevenDays});

  final Map dataMapSpecificSevenDays;

  Map countFoodAppearancesTotal() {
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

  // Map countFoodAppearancesBreakfast() {
  //   Map<String, double> countedFoodLastSevenDaysBreakfast = {
  //     'none': 0,
  //     'vegan': 0,
  //     'veggie': 0,
  //     'fish': 0,
  //     'chicken': 0,
  //     'pig': 0,
  //     'cow': 0
  //   };
  //
  //   dataMapSpecificSevenDays.forEach((key, value) {
  //     value.forEach((key, value) {
  //       if (key == 'Breakfast') {
  //         switch (value) {
  //           case 'none':
  //             {
  //               countedFoodLastSevenDaysBreakfast['none']++;
  //             }
  //             break;
  //
  //           case 'vegan':
  //             {
  //               countedFoodLastSevenDaysBreakfast['vegan']++;
  //             }
  //             break;
  //
  //           case 'veggie':
  //             {
  //               countedFoodLastSevenDaysBreakfast['veggie']++;
  //             }
  //             break;
  //
  //           case 'fish':
  //             {
  //               countedFoodLastSevenDaysBreakfast['fish']++;
  //             }
  //             break;
  //
  //           case 'chicken':
  //             {
  //               countedFoodLastSevenDaysBreakfast['chicken']++;
  //             }
  //             break;
  //           case 'pig':
  //             {
  //               countedFoodLastSevenDaysBreakfast['pig']++;
  //             }
  //             break;
  //           case 'cow':
  //             {
  //               countedFoodLastSevenDaysBreakfast['cow']++;
  //             }
  //             break;
  //           case '':
  //             {}
  //             break;
  //
  //           default:
  //             {}
  //             break;
  //         }
  //       }
  //     });
  //   });
  //   print(
  //       'countedMealsLastSevenDaysBreakfast $countedFoodLastSevenDaysBreakfast');
  //   return countedFoodLastSevenDaysBreakfast;
  // }

  // Map countFoodAppearancesLunch() {
  //   Map<String, double> countedFoodLastSevenDays = {
  //     'none': 0,
  //     'vegan': 0,
  //     'veggie': 0,
  //     'fish': 0,
  //     'chicken': 0,
  //     'pig': 0,
  //     'cow': 0
  //   };
  //
  //   dataMapSpecificSevenDays.forEach((key, value) {
  //     value.forEach((key, value) {
  //       switch (value) {
  //         case 'none':
  //           {
  //             countedFoodLastSevenDays['none']++;
  //           }
  //           break;
  //
  //         case 'vegan':
  //           {
  //             countedFoodLastSevenDays['vegan']++;
  //           }
  //           break;
  //
  //         case 'veggie':
  //           {
  //             countedFoodLastSevenDays['veggie']++;
  //           }
  //           break;
  //
  //         case 'fish':
  //           {
  //             countedFoodLastSevenDays['fish']++;
  //           }
  //           break;
  //
  //         case 'chicken':
  //           {
  //             countedFoodLastSevenDays['chicken']++;
  //           }
  //           break;
  //         case 'pig':
  //           {
  //             countedFoodLastSevenDays['pig']++;
  //           }
  //           break;
  //         case 'cow':
  //           {
  //             countedFoodLastSevenDays['cow']++;
  //           }
  //           break;
  //         case '':
  //           {}
  //           break;
  //
  //         default:
  //           {}
  //           break;
  //       }
  //     });
  //   });
  //   print('countedMealsLastSevenDays $countedFoodLastSevenDays');
  //   return countedFoodLastSevenDays;
  // }

  // Map countFoodAppearancesDinner() {
  //   Map<String, double> countedFoodLastSevenDays = {
  //     'none': 0,
  //     'vegan': 0,
  //     'veggie': 0,
  //     'fish': 0,
  //     'chicken': 0,
  //     'pig': 0,
  //     'cow': 0
  //   };
  //
  //   dataMapSpecificSevenDays.forEach((key, value) {
  //     value.forEach((key, value) {
  //       switch (value) {
  //         case 'none':
  //           {
  //             countedFoodLastSevenDays['none']++;
  //           }
  //           break;
  //
  //         case 'vegan':
  //           {
  //             countedFoodLastSevenDays['vegan']++;
  //           }
  //           break;
  //
  //         case 'veggie':
  //           {
  //             countedFoodLastSevenDays['veggie']++;
  //           }
  //           break;
  //
  //         case 'fish':
  //           {
  //             countedFoodLastSevenDays['fish']++;
  //           }
  //           break;
  //
  //         case 'chicken':
  //           {
  //             countedFoodLastSevenDays['chicken']++;
  //           }
  //           break;
  //         case 'pig':
  //           {
  //             countedFoodLastSevenDays['pig']++;
  //           }
  //           break;
  //         case 'cow':
  //           {
  //             countedFoodLastSevenDays['cow']++;
  //           }
  //           break;
  //         case '':
  //           {}
  //           break;
  //
  //         default:
  //           {}
  //           break;
  //       }
  //     });
  //   });
  //   print('countedMealsLastSevenDays $countedFoodLastSevenDays');
  //   return countedFoodLastSevenDays;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReportPie(countedFood: countFoodAppearancesTotal()),
        //ReportPie(countedFood: countFoodAppearancesBreakfast()),
      ],
    );
  }
}
