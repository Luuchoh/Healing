import 'package:flutter/material.dart';
import 'package:healing/Pages/InitialPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp();

  @override
  State<StatefulWidget> createState() => MyAppState();
}
class MyAppState extends State<MyApp> {

  MyAppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialPage(),
    );
  }

}
