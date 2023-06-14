import 'package:flutter/material.dart';

class TextBase extends StatelessWidget {

  String text;
  Color color;
  FontWeight weight;
  double? size;
  TextAlign? align;

  TextBase(
    this.text,
    {
      this.size = 16,
      this.color = Colors.black,
      this.weight = FontWeight.normal,
      this.align
    }
    );

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: align == null ? TextAlign.center : align,
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight
      ),
    );
  }

}