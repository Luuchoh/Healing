import 'package:flutter/material.dart';
import 'package:healing/Values/ColorsApp.dart';

class TextFieldBase extends StatelessWidget {

  String name;
  IconData icon;
  bool obscureText;
  double mx, my;
  TextEditingController? controller = TextEditingController();

  TextFieldBase(
      this.name,
      this.icon,
      {
        this.obscureText = false,
        this.mx = 0,
        this.my = 10,
        this.controller,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: my, horizontal: mx),
      height: 45,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor
          ),
          hintText: name,
          border: InputBorder.none,
        ),
      ),
    );
  }

}