import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/picker_food.dart';
import '../widgets/day_row.dart';
import '../screens/report_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final dataMap = {
    new DateTime(2021, 1, 12): {
      'todayB': 'chicken',
      'todayL': 'vegan',
      'todayD': 'fish'
    },
    new DateTime(2021, 1, 11): {
      'todayB': 'veggie',
      'todayL': 'pig',
      'todayD': 'fish'
    },
    new DateTime(2021, 1, 10): {
      'todayB': 'veggie',
      'todayL': 'fish',
      'todayD': 'fish'
    },
    new DateTime(2021, 1, 9): {
      'todayB': 'vegan',
      'todayL': 'pig',
      'todayD': 'cow'
    },
    new DateTime(2021, 1, 8): {
      'todayB': 'veggie',
      'todayL': 'chicken',
      'todayD': 'fish'
    },
    new DateTime(2021, 1, 7): {
      'todayB': 'pig',
      'todayL': 'fish',
      'todayD': 'vegan'
    },
  };

  @override
  _MyHomePageState createState() => _MyHomePageState(dataMap: dataMap);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({this.dataMap});

  List<String> meals = ['todayB', 'todayL', 'todayD'];
  List<String> food = ['vegan', 'veggie', 'fish', 'chicken', 'pig', 'cow'];

  var dataMap;

  List<String> days = ['Mon', 'Sun', 'Sat', 'Fri', 'Thurs', 'Wed', 'Tue'];
  DateTime dateStampToday;
  void getDays() {
    //and set currentDay for App and dataMap
    DateTime now = new DateTime.now();

    dateStampToday = new DateTime(now.year, now.month, now.day);
    print('dateStampToday $dateStampToday');

    if (!dataMap.containsKey(dateStampToday)) {
      dataMap[dateStampToday] = {
        'todayB': '',
        'todayL': '',
        'todayD': '',
      };
    }

    print('new dataMat $dataMap');

    if (now.weekday == 1) {
      return;
    } else if (now.weekday >= 2) {
      for (int i = 0; i < now.weekday - 1; i++) {
        days.insert(0, days.removeLast());
      }
    }
  }

  String selectedTime = 'todayB';
  void _selectTime(selectedIndex) {
    selectedTime = meals[selectedIndex];
  }

  String selectedFood = 'vegan';
  void _selectFood(selectedIndex) {
    selectedFood = food[selectedIndex];
  }

  void _submit() {
    setState(() {
      dataMap[dateStampToday][selectedTime] = selectedFood;
      print('updated to $dataMap');
    });
  }

  List<PickerFood> getFoodPickers() {
    List<PickerFood> foodPickers = [];
    food.forEach((foodItem) {
      foodPickers.add(PickerFood(meal: foodItem));
    });
    return foodPickers;
  }

  @override
  void initState() {
    super.initState();
    getDays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
      ),
      body: PageView(
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DayRow(
                              day: days[0], dataMap: dataMap[dateStampToday]),
                          DayRow(
                              day: days[1],
                              dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 1))]),
                          DayRow(
                              day: days[2],
                              dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 2))]),
                          DayRow(
                              day: days[3],
                              dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 3))]),
                          DayRow(
                              day: days[4],
                              dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 4))]),
                          DayRow(
                              day: days[5],
                              dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 5))]),
                          DayRow(
                              day: days[6],
                              dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 6))]),
                          // DayRow(
                          //     day: days[1],
                          //     dataMap: dataMap[DateTime(dateStampToday.year, dateStampToday.month, dateStampToday.day - 1)]),
                          // DayRow(
                          //     day: days[2],
                          //     dataMap: dataMap[dateStampToday - 2]),
                          // DayRow(
                          //     day: days[3],
                          //     dataMap: dataMap[dateStampToday - 3]),
                          // DayRow(
                          //     day: days[4],
                          //     dataMap: dataMap[dateStampToday - 4]),
                          // DayRow(
                          //     day: days[5],
                          //     dataMap: dataMap[dateStampToday - 5]),
                          // DayRow(
                          //     day: days[6],
                          //     dataMap: dataMap[dateStampToday - 6]),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 200.0,
                      width: 100.0,
                      child: CupertinoPicker(
                        itemExtent: 50.0,
                        onSelectedItemChanged: (selectedIndex) {
                          _selectTime(selectedIndex);
                        },
                        children: [
                          Center(
                            child: Text(
                              'Breakfast',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text('Lunch'),
                          ),
                          Center(
                            child: Text('Dinner'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200.0,
                      width: 150.0,
                      child: CupertinoPicker(
                        itemExtent: 80.0,
                        onSelectedItemChanged: (selectedIndex) {
                          _selectFood(selectedIndex);
                        },
                        children: getFoodPickers(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ReportScreen(food: food, dataMap: dataMap),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
