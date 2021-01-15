import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportScreenWeek extends StatefulWidget {
  @override
  _ReportScreenWeekState createState() => _ReportScreenWeekState();
}

class _ReportScreenWeekState extends State<ReportScreenWeek> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
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
                sections: showingSections()),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(7, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 55 : 40;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green[200],
            value: 2,
            title: '2',
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
            value: 5,
            title: '5',
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
            value: 6,
            title: '6',
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
            value: 6,
            title: '6',
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
            value: 1,
            title: '1',
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
            value: 1,
            title: '1',
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
            value: 2,
            title: '2',
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
