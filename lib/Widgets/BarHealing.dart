import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarHealing extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double halfScreenHeight = MediaQuery.of(context).size.height / 2;
    return Container(
      width: double.infinity,
      height: halfScreenHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bgLogin.png'),
          opacity: .7,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60),
          bottomLeft: Radius.circular(60),
        ),
        color: Colors.black,
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png')
        ],
      ),
    );
  }

}