import 'package:flutter/material.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/main.dart';

class TransitionApp {

  static closePageOrDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static openPage(BuildContext context, var page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static goMain(BuildContext context, {Count? count, User? user}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
        ModalRoute.withName("/MyApp")
    );
  }
}