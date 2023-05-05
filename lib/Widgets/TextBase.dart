import 'package:flutter/material.dart';

class TextBase extends StatelessWidget {

  String text;
  Color color;
  double? size;

  TextBase(this.text,{this.size= 16,this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }

}