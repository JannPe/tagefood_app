import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/picker_meal.dart';
import 'widgets/day_row.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Pacifico',
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'TageFood'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final dataMap = {
    'dateStamp': int,
    'todayB': '',
    'todayL': '',
    'todayD': '',
  };

  @override
  _MyHomePageState createState() => _MyHomePageState(dataMap: dataMap);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({this.dataMap});

  List<String> meals = ['todayB', 'todayL', 'todayD'];
  List<String> food = ['vegan', 'veggie', 'fish', 'chicken', 'pig', 'cow'];

  var dataMap;

  var mockOldData1 = {
    'todayB': 'veggie',
    'todayL': 'cow',
    'todayD': 'fish',
  };

  var mockOldData2 = {
    'todayB': 'chicken',
    'todayL': 'fish',
    'todayD': 'vegan',
  };

  var mockOldData3 = {
    'todayB': 'fish',
    'todayL': 'veggie',
    'todayD': 'fish',
  };

  List<String> days = ['Mon', 'Sun', 'Sat', 'Fri', 'Thurs', 'Wed', 'Tue'];
  void getDays() {
    DateTime now = new DateTime.now();

    dataMap['dateStamp'] = int.parse(
        now.year.toString() + now.month.toString() + now.day.toString());

    if (now.weekday == 1) {
      return;
    } else if (now.weekday >= 2) {
      for (int i = 0; i < now.weekday - 1; i++) {
        days.insert(0, days.removeLast());
      }
    }
    print(days);
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
      dataMap[selectedTime] = selectedFood;
      print('updated to $dataMap');
    });
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
      body: SafeArea(
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
                      DayRow(day: days[0], dataMap: dataMap),
                      DayRow(day: days[1], dataMap: mockOldData1),
                      DayRow(day: days[2], dataMap: mockOldData2),
                      DayRow(day: days[3], dataMap: mockOldData3),
                      DayRow(day: days[4], dataMap: mockOldData2),
                      DayRow(day: days[5], dataMap: mockOldData1),
                      DayRow(day: days[6], dataMap: mockOldData1),
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
                    children: [
                      PickerMeal(meal: food[0]),
                      PickerMeal(meal: food[1]),
                      PickerMeal(meal: food[2]),
                      PickerMeal(meal: food[3]),
                      PickerMeal(meal: food[4]),
                      PickerMeal(meal: food[5]),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
