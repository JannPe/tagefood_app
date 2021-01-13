import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/picker_meal.dart';
import 'components/day_row.dart';

void main() {
  var dataMap = {
    'todayB': '',
    'todayL': '',
    'todayD': '',
  };

  runApp(MyApp(dataMap: dataMap));
}

class MyApp extends StatelessWidget {
  MyApp({this.dataMap});

  var dataMap;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Pacifico',
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'TageFood', dataMap: dataMap),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.dataMap}) : super(key: key);

  final String title;
  var dataMap;

  @override
  _MyHomePageState createState() => _MyHomePageState(dataMap: dataMap);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({this.dataMap});

  List<String> meals = ['todayB', 'todayL', 'todayD'];
  List<String> food = ['vegan', 'veggie', 'fish', 'chicken', 'pig', 'cow'];
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
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

  void getToday() {
    DateTime now = new DateTime.now();
    print('now ${now.weekday}');

    List<String> days;

    if (now.weekday == 1) {
      days = [
        'Monday',
        'Sunday',
        'Saturday',
      ];
    } else if (now.weekday == 2) {
      days = ['Tuesday', 'Monday', 'Sunday'];
    }
    print(days);
  }

  String selectedTime;
  void _selectTime(selectedIndex) {
    selectedTime = meals[selectedIndex];
  }

  String selectedFood;
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
                      DayRow(day: days[3], dataMap: mockOldData2),
                      DayRow(day: days[3], dataMap: mockOldData1),
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
