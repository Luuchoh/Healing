import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:healing/Values/ColorsApp.dart';

class ButtonBase extends StatelessWidget {

  String name;
  var onTap;
  double width, letterSpacing, fontSize;

  ButtonBase(
    this.name,
    this.onTap,
    {
      this.width = double.infinity,
      this.letterSpacing = 4,
      this.fontSize = 16
    });

  @override
  Widget build(BuildContext context) {
    return
    SizedBox(
      height: 55,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          backgroundColor: primaryColor,
          padding: EdgeInsets.all(10),
        ),
        child: Center(
          child: Text(
            name.toUpperCase(),
            style: TextStyle(
              letterSpacing: letterSpacing,
              fontSize: fontSize,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

}