// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class ReportScreenWeek extends StatefulWidget {
//   ReportScreenWeek({this.dataMap, this.dateStampToday});
//
//   final Map<DateTime, dynamic> dataMap;
//   final DateTime dateStampToday;
//
//   @override
//   _ReportScreenWeekState createState() =>
//       _ReportScreenWeekState(dataMap: dataMap, dateStampToday: dateStampToday);
// }
//
// class _ReportScreenWeekState extends State<ReportScreenWeek> {
//   _ReportScreenWeekState({this.dataMap, this.dateStampToday});
//
//   int touchedIndex;
//   Map dataMap;
//   DateTime dateStampToday;
//   Map dataMapLastSevenDays;
//   Map<String, double> countedMealsLastSevenDays = {
//     'none': 0,
//     'vegan': 0,
//     'veggie': 0,
//     'fish': 0,
//     'chicken': 0,
//     'pig': 0,
//     'cow': 0
//   };
//
//   // void constructDataMapLastSevenDays() {
//   //   dataMapLastSevenDays = Map.from(dataMap)
//   //     ..removeWhere((key, value) =>
//   //         key.isBefore(dateStampToday.subtract(Duration(days: 6))));
//   //   print('dataMapLastSevenDays   $dataMapLastSevenDays');
//   // }
//
//   // void countFoodLastSevenDays() {
//   //   dataMapLastSevenDays.forEach((key, value) {
//   //     value.forEach((key, value) {
//   //       switch (value) {
//   //         case 'none':
//   //           {
//   //             countedMealsLastSevenDays['none']++;
//   //           }
//   //           break;
//   //
//   //         case 'vegan':
//   //           {
//   //             countedMealsLastSevenDays['vegan']++;
//   //           }
//   //           break;
//   //
//   //         case 'veggie':
//   //           {
//   //             countedMealsLastSevenDays['veggie']++;
//   //           }
//   //           break;
//   //
//   //         case 'fish':
//   //           {
//   //             countedMealsLastSevenDays['fish']++;
//   //           }
//   //           break;
//   //
//   //         case 'chicken':
//   //           {
//   //             countedMealsLastSevenDays['chicken']++;
//   //           }
//   //           break;
//   //         case 'pig':
//   //           {
//   //             countedMealsLastSevenDays['pig']++;
//   //           }
//   //           break;
//   //         case 'cow':
//   //           {
//   //             countedMealsLastSevenDays['cow']++;
//   //           }
//   //           break;
//   //         case '':
//   //           {}
//   //           break;
//   //
//   //         default:
//   //           {}
//   //           break;
//   //       }
//   //     });
//   //   });
//   //   print('countedMealsLastSevenDays $countedMealsLastSevenDays');
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//     constructDataMapLastSevenDays();
//     countFoodLastSevenDays();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AspectRatio(
//           aspectRatio: 1.3, //
//           child: Card(
//             color: Colors.white,
//             child: AspectRatio(
//               aspectRatio: 1,
//               child: PieChart(
//                 PieChartData(
//                     pieTouchData:
//                         PieTouchData(touchCallback: (pieTouchResponse) {
//                       setState(() {
//                         if (pieTouchResponse.touchInput is FlLongPressEnd ||
//                             pieTouchResponse.touchInput is FlPanEnd) {
//                           touchedIndex = -1;
//                         } else {
//                           touchedIndex = pieTouchResponse.touchedSectionIndex;
//                         }
//                       });
//                     }),
//                     borderData: FlBorderData(
//                       show: false,
//                     ),
//                     sectionsSpace: 0,
//                     centerSpaceRadius: 0,
//                     sections: showingSections(countedMealsLastSevenDays)),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<PieChartSectionData> showingSections(countedMealsLastSevenDays) {
//     return List.generate(7, (i) {
//       final isTouched = i == touchedIndex;
//       final double fontSize = isTouched ? 23 : 20;
//       final double radius = isTouched ? 130 : 120;
//       final double widgetSize = isTouched ? 55 : 50;
//
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: Colors.green[200],
//             value: countedMealsLastSevenDays['vegan'],
//             title: countedMealsLastSevenDays['vegan'].toInt().toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/vegan.png',
//               size: widgetSize,
//               borderColor: Colors.green[200],
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 1:
//           return PieChartSectionData(
//             color: Colors.green[400],
//             value: countedMealsLastSevenDays['veggie'],
//             title: countedMealsLastSevenDays['veggie'].toInt().toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/veggie.png',
//               size: widgetSize,
//               borderColor: Colors.green[400],
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 2:
//           return PieChartSectionData(
//             color: Colors.blueAccent,
//             value: countedMealsLastSevenDays['fish'],
//             title: countedMealsLastSevenDays['fish'].toInt().toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/fish.png',
//               size: widgetSize,
//               borderColor: Colors.blueAccent,
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 3:
//           return PieChartSectionData(
//             color: Colors.amberAccent,
//             value: countedMealsLastSevenDays['chicken'],
//             title: countedMealsLastSevenDays['chicken'].toInt().toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/chicken.png',
//               size: widgetSize,
//               borderColor: Colors.amberAccent,
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 4:
//           return PieChartSectionData(
//             color: Colors.deepOrangeAccent[200],
//             value: countedMealsLastSevenDays['pig'],
//             title: countedMealsLastSevenDays['pig'].toInt().toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/pig.png',
//               size: widgetSize,
//               borderColor: Colors.deepOrangeAccent[200],
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 5:
//           return PieChartSectionData(
//             color: Colors.deepPurpleAccent[200],
//             value: countedMealsLastSevenDays['cow'],
//             title: countedMealsLastSevenDays['cow'].toInt().toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/cow.png',
//               size: widgetSize,
//               borderColor: Colors.deepPurpleAccent,
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 6:
//           return PieChartSectionData(
//             color: Colors.blueGrey,
//             value: countedMealsLastSevenDays['none'],
//             title: countedMealsLastSevenDays['none'].toInt().toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/none.png',
//               size: widgetSize,
//               borderColor: Colors.blueGrey,
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         default:
//           return null;
//       }
//     });
//   }
// }
//
// class _Badge extends StatelessWidget {
//   final String imageAsset;
//   final double size;
//   final Color borderColor;
//
//   const _Badge(
//     this.imageAsset, {
//     Key key,
//     @required this.size,
//     @required this.borderColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: PieChart.defaultDuration,
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: borderColor,
//           width: 2,
//         ),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: Colors.black.withOpacity(.5),
//             offset: const Offset(3, 3),
//             blurRadius: 3,
//           ),
//         ],
//       ),
//       padding: EdgeInsets.all(size * .15),
//       child: Center(
//         child: Image.asset(
//           imageAsset,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }
