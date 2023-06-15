import 'package:flutter/material.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Widgets/ButtonBase.dart';
import 'package:healing/Widgets/TextBase.dart';

class ActivateServices extends StatelessWidget {

  User user;

  ActivateServices(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextBase('¿Deseas activar o desactivar tu servicio?',  weight: FontWeight.w600, align: TextAlign.start,),
            ),
            Container(
              width: 80,
              child: ButtonBase('Click', () => activateOrDesactive(user) , height: 30, fontSize: 10, letterSpacing: 2,),
            )
          ],
        ),
      ),
    );
  }

  activateOrDesactive (User user) async{
    if(user.isActive == 0 && user.isOnline == 0) {
      user.isActive = 1;
      user.isOnline = 1;
    } else {
      user.isActive = 0;
      user.isOnline = 0;
    }
    var userUpdated = await user.updateIsActivate();
    print("activate");
    print(userUpdated);
  }

}