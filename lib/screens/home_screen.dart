import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/food_image.dart';
import '../widgets/day_row.dart';
import '../screens/report_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  List<String> meals = ['todayB', 'todayL', 'todayD'];
  List<String> food = ['vegan', 'veggie', 'fish', 'chicken', 'pig', 'cow'];

  Map dataMap;

  List<String> days = ['Mon', 'Sun', 'Sat', 'Fri', 'Thurs', 'Wed', 'Tue'];
  DateTime dateStampToday;
  void setCurrentDayAndGetDays() {
    //and set currentDay for App and dataMap
    print('setCurrentDayAndGetDays started');
    DateTime now = new DateTime.now();
    dateStampToday = new DateTime(now.year, now.month, now.day);

    if (!dataMap.containsKey(dateStampToday)) {
      dataMap[dateStampToday] = {
        'todayB': '',
        'todayL': '',
        'todayD': '',
      };
    }
    print('New dataMap $dataMap');
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
      print('141 updated locally for TODAY to ${dataMap[dateStampToday]}');
    });
    setData();
  }

  Future setData() async {
    dataMapJSON = jsonEncode(dataMap.map((key, value) {
      String parsedKey = key.toString();
      return MapEntry(parsedKey, value);
    }));
    print('dataMapJSON SET  $dataMapJSON');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dataMapJSON', dataMapJSON);
  }

  Map<dynamic, dynamic> startingMap = {
    new DateTime(2021, 1, 13).toString(): {
      'todayB': 'chicken',
      'todayL': 'vegan',
      'todayD': 'fish'
    },
    new DateTime(2021, 1, 12).toString(): {
      'todayB': 'chicken',
      'todayL': 'vegan',
      'todayD': 'fish'
    },
    new DateTime(2021, 1, 11).toString(): {
      'todayB': 'veggie',
      'todayL': 'pig',
      'todayD': 'fish'
    },
    new DateTime(2021, 1, 10).toString(): {
      'todayB': 'veggie',
      'todayL': 'fish',
      'todayD': 'fish'
    },
    new DateTime(2021, 1, 9).toString(): {
      'todayB': 'vegan',
      'todayL': 'pig',
      'todayD': 'cow'
    },
    new DateTime(2021, 1, 8).toString(): {
      'todayB': 'veggie',
      'todayL': 'chicken',
      'todayD': 'fish'
    },
    new DateTime(2021, 1, 7).toString(): {
      'todayB': 'pig',
      'todayL': 'fish',
      'todayD': 'vegan'
    },
  };

  String dataMapJSON;

  Future getData() async {
    print('getData started');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dataMapJSON = (prefs.getString('dataMapJSON') ?? jsonEncode(startingMap));
      print('dataMapJSON GET  $dataMapJSON');
      await prefs.setString('dataMapJSON', dataMapJSON);
      Map<dynamic, dynamic> dataMapJSONDecoded = json.decode(dataMapJSON);
      Map<DateTime, dynamic> dataMapJSONDecodedParsed =
          dataMapJSONDecoded.map((key, value) {
        DateTime parsedKey = DateTime.parse(key);
        return MapEntry(parsedKey, value);
      });
      dataMap = dataMapJSONDecodedParsed;
      setState(() {});
    } catch (e) {
      print('ERROR FROM getData $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) => setCurrentDayAndGetDays());
  }

  List<FoodImage> getFoodImages(double suppliedHeight) {
    List<FoodImage> foodPickers = [];
    food.forEach((foodItem) {
      foodPickers.add(FoodImage(
        meal: foodItem,
        height: suppliedHeight,
      ));
    });
    return foodPickers;
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DayRow(day: days[0], dataMap: dataMap[dateStampToday]),
                      DayRow(
                          day: days[1],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 1))] ??
                              {'todayB': '', 'todayL': '', 'todayD': ''}),
                      //{'todayB':'','todayL':'','todayD':''},
                      DayRow(
                          day: days[2],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 2))] ??
                              {'todayB': '', 'todayL': '', 'todayD': ''}),
                      DayRow(
                          day: days[3],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 3))] ??
                              {'todayB': '', 'todayL': '', 'todayD': ''}),
                      DayRow(
                          day: days[4],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 4))] ??
                              {'todayB': '', 'todayL': '', 'todayD': ''}),
                      DayRow(
                          day: days[5],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 5))] ??
                              {'todayB': '', 'todayL': '', 'todayD': ''}),
                      DayRow(
                          day: days[6],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 6))] ??
                              {'todayB': '', 'todayL': '', 'todayD': ''}),
                    ],
                  ),
                ), //Days Overview
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 150.0,
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
                      height: 150.0,
                      width: 150.0,
                      child: CupertinoPicker(
                        itemExtent: 80.0,
                        onSelectedItemChanged: (selectedIndex) {
                          _selectFood(selectedIndex);
                        },
                        children: getFoodImages(20.0),
                      ),
                    ),
                  ],
                ), //Both Pickers
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
