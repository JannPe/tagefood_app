import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagefood_app/screens/report_screen.dart';
import '../widgets/food_image.dart';
import '../widgets/day_row.dart';
import '../services/storage_manager.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.dataMap}) : super(key: key);

  final String title;
  final Map dataMap;

  @override
  _MyHomePageState createState() => _MyHomePageState(dataMap: dataMap);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({this.dataMap});

  StorageManager storageManager = StorageManager();

  List<String> meals = ['Breakfast', 'Lunch', 'Dinner'];
  List<String> food = [
    'none',
    'vegan',
    'veggie',
    'fish',
    'chicken',
    'pig',
    'cow'
  ];

  Map dataMap; //central local storageMap to supply meals across the app

  List<String> days = ['Mon', 'Sun', 'Sat', 'Fri', 'Thurs', 'Wed', 'Tue'];
  DateTime dateStampToday;
  void setCurrentDayAndGetDays() {
    DateTime now = new DateTime.now();
    dateStampToday = new DateTime(now.year, now.month, now.day);
    print('dateStampToday in home $dateStampToday');

    if (!dataMap.containsKey(dateStampToday)) {
      //update dataMap with key of todays date
      dataMap[dateStampToday] = {
        'Breakfast': '',
        'Lunch': '',
        'Dinner': '',
      };
    }

    if (now.weekday == 1) {
      //set days List to match to today and correct prior days
      return;
    } else if (now.weekday >= 2) {
      for (int i = 0; i < now.weekday - 1; i++) {
        days.insert(0, days.removeLast());
      }
    }
  }

  String selectedTime = 'Breakfast';
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
      storageManager.setData(dataMap);
    });
  }

  Map constructDataMapForSpecificSevenDays(int start, int end) {
    Map dataMapSelectedSevenDays = Map.from(dataMap);

    dataMapSelectedSevenDays.removeWhere((key, value) =>
        key.isBefore(dateStampToday.subtract(Duration(days: start))) ||
        key.isAfter(dateStampToday.subtract(Duration(days: end))));

    print('dataMapSelectedSevenDays construct   $dataMapSelectedSevenDays');
    return dataMapSelectedSevenDays;
  }

  @override
  void initState() {
    super.initState();
    setCurrentDayAndGetDays();
    setState(() {});
  }

  List<FoodImage> getFoodImages(double suppliedHeight) {
    List<FoodImage> foodImages = [];
    food.forEach((foodItem) {
      foodImages.add(FoodImage(
        meal: foodItem,
        height: suppliedHeight,
      ));
    });
    return foodImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DayRow(day: days[0], dataMap: dataMap[dateStampToday]),
                      DayRow(
                          day: days[1],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 1))] ??
                              {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                      DayRow(
                          day: days[2],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 2))] ??
                              {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                      DayRow(
                          day: days[3],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 3))] ??
                              {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                      DayRow(
                          day: days[4],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 4))] ??
                              {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                      DayRow(
                          day: days[5],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 5))] ??
                              {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                      DayRow(
                          day: days[6],
                          dataMap: dataMap[
                                  dateStampToday.subtract(Duration(days: 6))] ??
                              {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
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
                              style: TextStyle(fontFamily: 'JosefinSans'),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Lunch',
                              style: TextStyle(fontFamily: 'JosefinSans'),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Dinner',
                              style: TextStyle(fontFamily: 'JosefinSans'),
                            ),
                          ),
                        ],
                      ),
                    ), // Meal Picker
                    Container(
                      height: 150.0,
                      width: 150.0,
                      child: CupertinoPicker(
                        scrollController:
                            FixedExtentScrollController(initialItem: 1),
                        itemExtent: 80.0,
                        onSelectedItemChanged: (selectedIndex) {
                          _selectFood(selectedIndex);
                        },
                        children: getFoodImages(20.0),
                      ),
                    ), //Food Picker
                  ],
                ),
                //Both Pickers
              ],
            ),
          ),
          ReportScreen(
              dataMapSpecificSevenDays:
                  constructDataMapForSpecificSevenDays(6, 0)),
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
