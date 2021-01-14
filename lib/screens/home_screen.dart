import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/food_image.dart';
import '../widgets/day_row.dart';
import '../screens/report_screen.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final dataMap = {
    new DateTime(2021, 1, 13): {
      'todayB': 'chicken',
      'todayL': 'vegan',
      'todayD': 'fish'
    },
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

  // File jsonFile;
  // Directory dir;
  // String fileName = 'myJSONFile.json';
  // bool fileExists = false;
  // Map<DateTime, String> fileContent;

  // void createFile(Map<DateTime, Map> content, Directory dir, String fileName) {
  //   print('Creating File');
  //   File file = new File(dir.path + '/' + fileName);
  //   file.createSync();
  //   fileExists = true;
  //   file.writeAsStringSync(jsonEncode(content));
  //   print('jsonEncode(content) ${jsonEncode(content)}');
  // }

  // void writeToFile() {
  //   print('Writing to a file');
  //   Map<DateTime, Map> content = dataMap;
  //   if (fileExists) {
  //     print('File exists');
  //     print('content$content');
  //     Map<DateTime, Map> jsonFileContent =
  //         json.decode(jsonFile.readAsStringSync());
  //     print('json File Content $jsonFileContent');
  //     jsonFileContent.addAll(content);
  //     jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
  //   } else {
  //     print('Files does not exist');
  //     createFile(content, dir, fileName);
  //   }
  //   this.setState(() {
  //     fileContent = jsonDecode(jsonFile.readAsStringSync());
  //   });
  // } // youtube video approach

  List<String> meals = ['todayB', 'todayL', 'todayD'];
  List<String> food = ['vegan', 'veggie', 'fish', 'chicken', 'pig', 'cow'];

  var dataMap;

  List<String> days = ['Mon', 'Sun', 'Sat', 'Fri', 'Thurs', 'Wed', 'Tue'];
  DateTime dateStampToday;

  void getDays() {
    //and set currentDay for App and dataMap
    print('Getdays started');
    DateTime now = new DateTime.now();
    dateStampToday = new DateTime(now.year, now.month, now.day);
    if (!dataMap.containsKey(dateStampToday)) {
      dataMap[dateStampToday] = {
        'todayB': '',
        'todayL': '',
        'todayD': '',
      };
    }
    print('115 new dataMat $dataMap');
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
      print('141 updated locally to $dataMap');
      //writeToFile();
    });
  }

  Map startingMap = {
    new DateTime(2021, 1, 13).toString(): {
      'todayB': 'chicken',
      'todayL': 'vegan',
      'todayD': 'fish'
    }
  };

  String dataMapJSON;

  Future getData() async {
    print('getData started');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('jsonEncode(startingMap)${jsonEncode(startingMap)}');
      print('LINE 160');
      print('prefs.getString(dataMapJSON)${prefs.getString('dataMapJSON')}');
      dataMapJSON = (prefs.getString('dataMapJSON') ?? jsonEncode(startingMap));
      print('startingMap$startingMap');
      await prefs.setString('dataMapJSON', dataMapJSON);
      Map dataMapJSONDecoded = json.decode(dataMapJSON);
      print('dataMapJSONDecoded $dataMapJSONDecoded');
      dataMapJSONDecoded.forEach((k, v) {
        k = DateTime.parse(k);
        print('KEY Type ${k.runtimeType}');
      });
      print('dataMapJSON $dataMapJSON');
      print('dataMap $dataMap');
      print('getData ended');
    } catch (e) {
      print('ERROR FROM LINE 161 $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) => getDays());
    // getApplicationDocumentsDirectory().then((Directory directory) {
    //   dir = directory;
    //   jsonFile = new File(dir.path + '/' + fileName);
    //   fileExists = jsonFile.existsSync();
    //   if (fileExists)
    //     this.setState(
    //         () => fileContent = jsonDecode(jsonFile.readAsStringSync()));
    // }); // youtube video apporach
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
                    ],
                  ),
                ), //Days Overview
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
