import 'package:flutter/material.dart';
import 'package:healing/Values/ColorsApp.dart';

class SnackBarApp extends SnackBar {

  Widget? widget;

  SnackBarApp(this.widget): super(
    backgroundColor: primaryColor,
    content: widget!,
    duration: const Duration(seconds: 5)
  );

}