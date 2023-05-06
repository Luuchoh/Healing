import 'package:flutter/material.dart';

class TextBase extends StatelessWidget {

  String text;
  Color color;
  FontWeight weight;
  double? size;

  TextBase(
    this.text,
    {
      this.size = 16,
      this.color = Colors.black,
      this.weight = FontWeight.normal
    }
    );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight
      ),
    );
  }

}