import 'package:flutter/material.dart';
import 'package:healing/Values/ColorsApp.dart';
import 'package:healing/Widgets/TextBase.dart';

class CardSpecialist extends StatelessWidget {

  IconData icon;
  String speciality;

  CardSpecialist(this.speciality, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 105,
      width: 155,
      decoration: BoxDecoration(
        color: cardSpecialist,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              alignment: AlignmentDirectional.centerEnd,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            color: Colors.amber,
            child: Center(
              child: TextBase(speciality, size: 12, weight: FontWeight.w600,),
            ),
          ),
        ],
      ),
    );
  }
  
}