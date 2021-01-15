import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/food_image.dart';
import '../widgets/day_row.dart';
import '../screens/report_screen.dart';
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

  List<String> meals = ['todayB', 'todayL', 'todayD'];
  List<String> food = [
    'none',
    'vegan',
    'veggie',
    'fish',
    'chicken',
    'pig',
    'cow'
  ];

  //Map dataMap; //central local storageMap to supply meals across the app
  Map dataMap;

  List<String> days = ['Mon', 'Sun', 'Sat', 'Fri', 'Thurs', 'Wed', 'Tue'];
  DateTime dateStampToday;
  void setCurrentDayAndGetDays() {
    print('setCurrentDayAndGetDays started');
    DateTime now = new DateTime.now();
    dateStampToday = new DateTime(now.year, now.month, now.day);

    if (!dataMap.containsKey(dateStampToday)) {
      //update dataMap with key of todays date
      dataMap[dateStampToday] = {
        'todayB': '',
        'todayL': '',
        'todayD': '',
      };
    }
    print('New dataMap $dataMap');

    if (now.weekday == 1) {
      //set days List to match to today and correct prior days
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
  }

  @override
  void initState() {
    super.initState();
    setCurrentDayAndGetDays();
    setState(() {});
    // storageManager
    //     .getData()
    //     .then((value) => dataMap = storageManager.dataMapJSONDecodedParsed)
    //     .then((value) => print(
    //         '150 dataMapJSONDecodedParsed ${storageManager.dataMapJSONDecodedParsed}'))
    //     .then((value) => setCurrentDayAndGetDays())
    //     .then((value) => setState(() {}));
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
