import 'package:flutter/material.dart';
import 'package:healing/Values/ColorsApp.dart';


class DropDownBase extends StatefulWidget {

  List<String> list;
  double mx, my;
  IconData icon;
  Function(String?)? validator;
  Function(String?) onChanged;
  String dropdownValue;

  DropDownBase(
      this.list,
      this.icon,
      this.dropdownValue,
      this.onChanged,
      {
        this.validator,
        this.mx = 0,
        this.my = 10,
      }
      );

  @override
  State<StatefulWidget> createState() => DropDowndBaseState(list, icon, dropdownValue, onChanged, mx, my, validator: validator, );
}

class DropDowndBaseState extends State<DropDownBase> {

  List<String> list;
  double mx, my;
  IconData icon;
  Function(String?)? validator;
  Function(String?) onChanged;
  String dropdownValue;

  DropDowndBaseState(
      this.list,
      this.icon,
      this.dropdownValue,
      this.onChanged,
      this.mx,
      this.my,
      {
        this.validator,
      }
      );

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
      child: DropdownButtonFormField<String>(
        // validator: (value) => validator!(value),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor
          ),
          border: InputBorder.none
        ),
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        onChanged: (value) => onChanged(value),
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}
