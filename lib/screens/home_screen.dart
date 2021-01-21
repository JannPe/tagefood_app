import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagefood_app/screens/report_screen.dart';
import '../widgets/food_image.dart';
import '../widgets/day_row.dart';
import '../services/storage_manager.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.dataMap}) : super(key: key);

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
    'pork',
    'beef'
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
    } else {
      for (int i = 0; i < now.weekday - 1; i++) {
        days.insert(0, days.removeLast());
      }
    }
  }

  int setInitialSelectedMeal() {
    //setsInitialMeal and lets MealPicker adapt to current time
    int currentHour = new DateTime.now().hour;
    print('currentHours $currentHour');
    if (currentHour > 11 && currentHour < 17) {
      selectedMeal = 'Lunch';
      return 1;
    } else if (currentHour >= 17 && currentHour < 23) {
      selectedMeal = 'Dinner';
      return 2;
    } else {
      selectedMeal = 'Breakfast';
      return 0;
    }
  }

  String selectedMeal;

  void _selectMeal(selectedIndex) {
    selectedMeal = meals[selectedIndex];
  }

  String selectedFood = 'vegan';
  void _selectFood(selectedIndex) {
    selectedFood = food[selectedIndex];
  }

  void _submit() {
    setState(() {
      dataMap[dateStampToday][selectedMeal] = selectedFood;
      //print('updated locally for TODAY to ${dataMap[dateStampToday]}');
      storageManager.setData(dataMap);
    });
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

  Map constructDataMapForSpecificDays(int start, int end) {
    Map dataMapSelectedDays = Map.from(dataMap);

    dataMapSelectedDays.removeWhere((key, value) =>
        key.isBefore(dateStampToday.subtract(Duration(days: start))) ||
        key.isAfter(dateStampToday.subtract(Duration(days: end))));

    return dataMapSelectedDays;
  }

  DateTime minDate;

  void calculateMinDate() {
    List dates = dataMap.keys.toList();
    minDate = dates[0];
    dates.forEach((date) {
      if (date.isBefore(minDate)) {
        minDate = date;
      }
    });
  }

  List<Widget> getRecordScreens(int suppliedStart, int suppliedEnd) {
    List<Widget> recordScreens = [];

    DateTime maxDate = dateStampToday;

    int daysBetweenMinAndMax = maxDate.difference(minDate).inDays;

    double daysIntervalsBetweenMinAndMax =
        daysBetweenMinAndMax / suppliedStart + 1;

    print('daysIntervalsBetweenMinAndMax $daysIntervalsBetweenMinAndMax');

    int start = suppliedStart;
    int end = suppliedEnd;

    for (var i = 0; i < (daysIntervalsBetweenMinAndMax - 1).ceil(); i++) {
      recordScreens.add(ReportScreen(
          dataMapSpecificDays: constructDataMapForSpecificDays(start, end)));
      start += suppliedStart + 1;
      end += suppliedStart + 1;
    }
    return recordScreens;
  }

  @override
  void initState() {
    super.initState();
    calculateMinDate();
    setCurrentDayAndGetDays();
    setInitialSelectedMeal();
    setState(() {});
  }

  @override //enable user to change/enter any day. maybe with calendar? swuiping to the left? or down with a pop up card
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.green,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Home'),
              Tab(text: '7 Days'),
              Tab(text: '30 Days'),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Builder(
        builder: (context) => TabBarView(
          children: [
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DayRow(
                            day: days[0],
                            date: dateStampToday,
                            dataMap: dataMap[dateStampToday],
                            isToday: true),
                        DayRow(
                            day: days[1],
                            date: dateStampToday.subtract(Duration(days: 1)),
                            dataMap: dataMap[dateStampToday
                                    .subtract(Duration(days: 1))] ??
                                {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                        DayRow(
                            day: days[2],
                            date: dateStampToday.subtract(Duration(days: 2)),
                            dataMap: dataMap[dateStampToday
                                    .subtract(Duration(days: 2))] ??
                                {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                        DayRow(
                            day: days[3],
                            date: dateStampToday.subtract(Duration(days: 3)),
                            dataMap: dataMap[dateStampToday
                                    .subtract(Duration(days: 3))] ??
                                {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                        DayRow(
                            day: days[4],
                            date: dateStampToday.subtract(Duration(days: 4)),
                            dataMap: dataMap[dateStampToday
                                    .subtract(Duration(days: 4))] ??
                                {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                        DayRow(
                            day: days[5],
                            date: dateStampToday.subtract(Duration(days: 5)),
                            dataMap: dataMap[dateStampToday
                                    .subtract(Duration(days: 5))] ??
                                {'Breakfast': '', 'Lunch': '', 'Dinner': ''}),
                        DayRow(
                            day: days[6],
                            date: dateStampToday.subtract(Duration(days: 6)),
                            dataMap: dataMap[dateStampToday
                                    .subtract(Duration(days: 6))] ??
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
                          scrollController: FixedExtentScrollController(
                              initialItem: setInitialSelectedMeal()),
                          itemExtent: 50.0,
                          onSelectedItemChanged: (selectedIndex) {
                            _selectMeal(selectedIndex);
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
                      ), //FoodPicker
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.lightGreen,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          iconSize: 40.0,
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            _submit();
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '$selectedFood added',
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ), //button
                ],
              ),
            ),
            Scrollbar(
              child: PageView(
                scrollDirection: Axis.vertical,
                children: getRecordScreens(6, 0),
              ),
            ),
            Scrollbar(
              child: PageView(
                scrollDirection: Axis.vertical,
                children: getRecordScreens(30, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
