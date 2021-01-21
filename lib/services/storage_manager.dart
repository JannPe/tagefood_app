import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  String dataMapJSON;

  Map<String, Map> startingMap = {
    new DateTime(2021, 1, 20).toString(): {
      'Breakfast': 'veggie',
      'Lunch': 'vegan',
      'Dinner': 'chicken'
    },
    new DateTime(2021, 1, 19).toString(): {
      'Breakfast': 'none',
      'Lunch': 'pork',
      'Dinner': 'chicken'
    },
    new DateTime(2021, 1, 18).toString(): {
      'Breakfast': 'none',
      'Lunch': 'none',
      'Dinner': 'chicken'
    },
    new DateTime(2021, 1, 17).toString(): {
      'Breakfast': 'veggie',
      'Lunch': 'chicken',
      'Dinner': 'pork'
    },
    new DateTime(2021, 1, 16).toString(): {
      'Breakfast': 'pork',
      'Lunch': 'none',
      'Dinner': 'pork'
    },
    new DateTime(2021, 1, 15).toString(): {
      'Breakfast': 'none',
      'Lunch': 'veggie',
      'Dinner': 'veggie'
    },
    new DateTime(2021, 1, 14).toString(): {
      'Breakfast': 'none',
      'Lunch': 'pork',
      'Dinner': 'none'
    },
  }; //mock Data to show the app, to be deleted later
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
