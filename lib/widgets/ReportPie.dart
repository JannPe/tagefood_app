import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportPie extends StatefulWidget {
  ReportPie({this.countedFood, this.size, this.badges});

  final Map<String, double> countedFood;
  final double size;
  final bool badges;

  @override
  _ReportPieState createState() => _ReportPieState();
}

class _ReportPieState extends State<ReportPie> {
  _ReportPieState();

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
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
            sections: showingSections(widget.countedFood)),
      ),
    );
  }

  List<PieChartSectionData> showingSections(countedFood) {
    return List.generate(7, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize =
          isTouched ? widget.size * 0.25 : widget.size * 0.2;
      final double radius = isTouched ? widget.size * 1.1 : widget.size;
      final double widgetSize =
          isTouched ? widget.size * 0.5 * 1.1 : widget.size * 0.5;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green[200],
            value: countedFood['vegan'],
            title: countedFood['vegan'] == 0
                ? ''
                : countedFood['vegan'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: !widget.badges || countedFood['vegan'] == 0
                ? _Badge(
                    'assets/.png',
                    size: 0.0,
                    borderColor: Colors.amberAccent,
                  )
                : _Badge(
                    'assets/vegan.png',
                    size: widgetSize,
                    borderColor: Colors.amberAccent,
                  ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green[400],
            value: countedFood['veggie'],
            title: countedFood['veggie'] == 0
                ? ''
                : countedFood['veggie'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: !widget.badges || countedFood['veggie'] == 0
                ? _Badge(
                    'assets/.png',
                    size: 0.0,
                    borderColor: Colors.amberAccent,
                  )
                : _Badge(
                    'assets/veggie.png',
                    size: widgetSize,
                    borderColor: Colors.amberAccent,
                  ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blueAccent,
            value: countedFood['fish'],
            title: countedFood['fish'] == 0
                ? ''
                : countedFood['fish'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: !widget.badges || countedFood['fish'] == 0
                ? _Badge(
                    'assets/.png',
                    size: 0.0,
                    borderColor: Colors.amberAccent,
                  )
                : _Badge(
                    'assets/fish.png',
                    size: widgetSize,
                    borderColor: Colors.amberAccent,
                  ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.amberAccent,
            value: countedFood['chicken'],
            title: countedFood['chicken'] == 0
                ? ''
                : countedFood['chicken'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: !widget.badges || countedFood['chicken'] == 0
                ? _Badge(
                    'assets/.png',
                    size: 0.0,
                    borderColor: Colors.amberAccent,
                  )
                : _Badge(
                    'assets/chicken.png',
                    size: widgetSize,
                    borderColor: Colors.amberAccent,
                  ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: Colors.deepOrangeAccent[200],
            value: countedFood['pork'],
            title: countedFood['pork'] == 0
                ? ''
                : countedFood['pork'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: !widget.badges || countedFood['pork'] == 0
                ? _Badge(
                    'assets/.png',
                    size: 0.0,
                    borderColor: Colors.amberAccent,
                  )
                : _Badge(
                    'assets/pork.png',
                    size: widgetSize,
                    borderColor: Colors.amberAccent,
                  ),
            badgePositionPercentageOffset: .98,
          );
        case 5:
          return PieChartSectionData(
            color: Colors.deepPurpleAccent[200],
            value: countedFood['beef'],
            title: countedFood['beef'] == 0
                ? ''
                : countedFood['beef'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: !widget.badges || countedFood['beef'] == 0
                ? _Badge(
                    'assets/.png',
                    size: 0.0,
                    borderColor: Colors.amberAccent,
                  )
                : _Badge(
                    'assets/beef.png',
                    size: widgetSize,
                    borderColor: Colors.amberAccent,
                  ),
            badgePositionPercentageOffset: .98,
          );
        case 6:
          return PieChartSectionData(
            color: Colors.blueGrey,
            value: countedFood['none'],
            title: countedFood['none'] == 0
                ? ''
                : countedFood['none'].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: !widget.badges || countedFood['none'] == 0
                ? _Badge(
                    'assets/.png',
                    size: 0.0,
                    borderColor: Colors.amberAccent,
                  )
                : _Badge(
                    'assets/none.png',
                    size: widgetSize,
                    borderColor: Colors.amberAccent,
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
