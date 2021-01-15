import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/storage_manager.dart';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Map<DateTime, dynamic> dataMap;

  @override
  void initState() {
    super.initState();
    collectData();
  }

  void collectData() async {
    StorageManager storageManager = StorageManager();
    await storageManager.getData();

    dataMap = storageManager.dataMapJSONDecodedParsed;

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyHomePage(title: 'TageFood', dataMap: dataMap);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.green,
        ),
      ),
    );
  }
}
