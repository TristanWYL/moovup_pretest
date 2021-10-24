import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:moovup/ui/pages/front_page.dart';

import 'model/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // Loat the json data
    
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moovup Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DataProvider(),
      builder: EasyLoading.init(),
    );
  }
}

class DataProvider extends StatelessWidget {
  DataProvider({Key? key}) : super(key: key);
  final futureData = loadJson();
  @override
  Widget build(BuildContext context) {
    return FrontPage(personsData: futureData,);
  }
}
