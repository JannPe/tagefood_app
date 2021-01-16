import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportPie extends StatefulWidget {
  ReportPie({this.countedFood});

  Map<String, double> countedFood;

  @override
  _ReportPieState createState() => _ReportPieState();
}

class _ReportPieState extends State<ReportPie> {
  _ReportPieState();

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.3, //
          child: Card(
            color: Colors.white,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: showingSections(widget.countedFood)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(countedFood) {
    return List.generate(7, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 23 : 20;
      final double radius = isTouched ? 130 : 120;
      final double widgetSize = isTouched ? 55 : 50;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green[200],
            value: countedFood['vegan'],
            title: countedFood['vegan'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/vegan.png',
              size: widgetSize,
              borderColor: Colors.green[200],
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green[400],
            value: countedFood['veggie'],
            title: countedFood['veggie'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/veggie.png',
              size: widgetSize,
              borderColor: Colors.green[400],
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blueAccent,
            value: countedFood['fish'],
            title: countedFood['fish'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/fish.png',
              size: widgetSize,
              borderColor: Colors.blueAccent,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.amberAccent,
            value: countedFood['chicken'],
            title: countedFood['chicken'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/chicken.png',
              size: widgetSize,
              borderColor: Colors.amberAccent,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: Colors.deepOrangeAccent[200],
            value: countedFood['pig'],
            title: countedFood['pig'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/pig.png',
              size: widgetSize,
              borderColor: Colors.deepOrangeAccent[200],
            ),
            badgePositionPercentageOffset: .98,
          );
        case 5:
          return PieChartSectionData(
            color: Colors.deepPurpleAccent[200],
            value: countedFood['cow'],
            title: countedFood['cow'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/cow.png',
              size: widgetSize,
              borderColor: Colors.deepPurpleAccent,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 6:
          return PieChartSectionData(
            color: Colors.blueGrey,
            value: countedFood['none'],
            title: countedFood['none'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/none.png',
              size: widgetSize,
              borderColor: Colors.blueGrey,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          return null;
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String imageAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.imageAsset, {
    Key key,
    @required this.size,
    @required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(
          imageAsset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
