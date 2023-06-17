import 'package:flutter/material.dart';

import 'package:healing/Helpers/helpers.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Pages/HomePage.dart';

import 'package:healing/Values/ColorsApp.dart';

class ButtonTerminateServices extends StatelessWidget {
  User user, peer;
  Count count;

  ButtonTerminateServices(this.user, this.peer, this.count);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.exit_to_app_sharp,
            color: primaryColor,
          ),
          onPressed: () => terminateServices(context)
        ),
      ),
    );
  }

  terminateServices (BuildContext context) async{
    await peer.updateMapMedic( stateMap: 0, userPatient: '');
    Navigator.pushReplacement(context, navegarMapaFadeIn(context, HomePage(user, count)));
  }
}
