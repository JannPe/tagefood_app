import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  String dataMapJSON;

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
  Map<DateTime, dynamic> dataMapJSONDecodedParsed;

  Future getData() async {
    print('getData started');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dataMapJSON = (prefs.getString('dataMapJSON') ?? jsonEncode(startingMap));
      print('dataMapJSON GET  $dataMapJSON');
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
    print('dataMapJSON SET  $dataMapJSON');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dataMapJSON', dataMapJSON);
  }
}
