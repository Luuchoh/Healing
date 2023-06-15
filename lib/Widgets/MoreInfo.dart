
import 'package:flutter/material.dart';
import 'package:healing/Values/ColorsApp.dart';
import 'package:healing/Widgets/ButtonBase.dart';
import 'package:healing/Widgets/TextBase.dart';

class MoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: MediaQuery.of(context).size.height * 0.20,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextBase('Estamos para ayudarte en todo momento.', color: Colors.white, weight: FontWeight.bold, size: 14,),
                    ButtonBase('Mas info.', () {}, color: Colors.white, height: 40, fontSize: 12,)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              )
            ),
          ],
        )
    );
  }

}