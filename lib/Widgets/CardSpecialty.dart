import 'package:flutter/material.dart';
import 'package:healing/Values/ColorsApp.dart';
import 'package:healing/Widgets/TextBase.dart';

class CardSpeciality extends StatelessWidget {

  IconData icon;
  String speciality;

  CardSpeciality(this.speciality, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 85,
      width: 105,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          TextBase(speciality, color: Colors.white,),
        ],
      ),
    );
  }
  
}