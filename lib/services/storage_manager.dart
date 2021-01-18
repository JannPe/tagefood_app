import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  String dataMapJSON;

  Map<String, Map> startingMap = {
    new DateTime(2021, 1, 17).toString(): {
      'Breakfast': 'veggie',
      'Lunch': 'none',
      'Dinner': 'cow'
    },
    new DateTime(2021, 1, 16).toString(): {
      'Breakfast': 'pig',
      'Lunch': 'fish',
      'Dinner': 'veggie'
    },
    new DateTime(2021, 1, 15).toString(): {
      'Breakfast': 'none',
      'Lunch': 'veggie',
      'Dinner': 'fish'
    },
    new DateTime(2021, 1, 14).toString(): {
      'Breakfast': 'fish',
      'Lunch': 'none',
      'Dinner': 'vegan'
    },
    new DateTime(2021, 1, 13).toString(): {
      'Breakfast': 'chicken',
      'Lunch': 'vegan',
      'Dinner': 'fish'
    },
    new DateTime(2021, 1, 12).toString(): {
      'Breakfast': 'chicken',
      'Lunch': 'vegan',
      'Dinner': 'fish'
    },
    new DateTime(2021, 1, 11).toString(): {
      'Breakfast': 'veggie',
      'Lunch': 'pig',
      'Dinner': 'fish'
    },
    new DateTime(2021, 1, 10).toString(): {
      'Breakfast': 'veggie',
      'Lunch': 'fish',
      'Dinner': 'fish'
    },
    new DateTime(2021, 1, 9).toString(): {
      'Breakfast': 'vegan',
      'Lunch': 'pig',
      'Dinner': 'cow'
    },
    new DateTime(2021, 1, 8).toString(): {
      'Breakfast': 'vegan',
      'Lunch': 'pig',
      'Dinner': 'cow'
    },
    new DateTime(2021, 1, 7).toString(): {
      'Breakfast': 'vegan',
      'Lunch': 'pig',
      'Dinner': 'cow'
    },
    new DateTime(2021, 1, 6).toString(): {
      'Breakfast': 'vegan',
      'Lunch': 'pig',
      'Dinner': 'cow'
    },
    new DateTime(2021, 1, 5).toString(): {
      'Breakfast': 'vegan',
      'Lunch': 'pig',
      'Dinner': 'cow'
    },
    new DateTime(2021, 1, 4).toString(): {
      'Breakfast': 'vegan',
      'Lunch': 'pig',
      'Dinner': 'cow'
    },
    new DateTime(2021, 1, 3).toString(): {
      'Breakfast': 'vegan',
      'Lunch': 'pig',
      'Dinner': 'cow'
    },
    new DateTime(2021, 1, 2).toString(): {
      'Breakfast': 'vegan',
      'Lunch': 'pig',
      'Dinner': 'cow'
    },
    new DateTime(2021, 1, 1).toString(): {
      'Breakfast': 'vegan',
      'Lunch': 'pig',
      'Dinner': 'cow'
    },
  }; //mock Data to show the app
  Map<DateTime, dynamic> dataMapJSONDecodedParsed;

  Future getData() async {
    //print('getData started');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dataMapJSON = (prefs.getString('dataMapJSON') ?? jsonEncode(startingMap));
      //print('dataMapJSON GET  $dataMapJSON');
      await prefs.setString('dataMapJSON', dataMapJSON);
      Map<dynamic, dynamic> dataMapJSONDecoded = json.decode(dataMapJSON);
      dataMapJSONDecodedParsed = dataMapJSONDecoded.map((key, value) {
        DateTime parsedKey = DateTime.parse(key);
        return MapEntry(parsedKey, value);
      });
      return;
    } catch (e) {
      print('ERROR FROM getData $e');
    }
  }

  Future setData(dataMap) async {
    dataMapJSON = jsonEncode(dataMap.map((key, value) {
      String parsedKey = key.toString();
      return MapEntry(parsedKey, value);
    }));
    //print('dataMapJSON SET  $dataMapJSON');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dataMapJSON', dataMapJSON);
  }
}
