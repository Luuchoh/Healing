import 'package:flutter/material.dart';
import 'package:healing/Values/ColorsApp.dart';

class TextFormFieldBase extends StatelessWidget {

  String name;
  IconData icon;
  bool obscureText;
  TextInputType keyboardType;
  Function(String?)? validator;
  double mx, my;
  TextEditingController? controller = TextEditingController();

  TextFormFieldBase(
      this.name,
      this.icon,
      {
        this.obscureText = false,
        this.keyboardType = TextInputType.text,
        this.mx = 0,
        this.my = 10,
        this.controller,
        this.validator,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: my, horizontal: mx),
      constraints: BoxConstraints(
        minHeight: 45
      ),
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
      child: TextFormField(
        focusNode: FocusNode(),
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (value) => validator!(value),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor
          ),
          hintText: name,
          border: InputBorder.none
        ),
      ),
    );
  }

}