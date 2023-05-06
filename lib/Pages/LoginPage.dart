import 'package:flutter/material.dart';
import 'package:healing/Widgets/BarHealing.dart';
import 'package:healing/Widgets/ButtonBase.dart';
import 'package:healing/Widgets/TextBase.dart';
import 'package:healing/Widgets/TextFieldBase.dart';

class LoginPage extends StatelessWidget{

  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight,
              maxHeight: double.infinity
            ),
            child: Stack(
              children: [
                BarHealing(),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.40,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(40.0))
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    // color: Colors.grey[300],
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 45),
                            child: TextBase('Bienvenido a healthcare', size: 20, weight: FontWeight.bold,),
                          ),
                          TextFieldBase('Usuario', Icons.person, controller: ctrlEmail),
                          TextFieldBase('Contraseña', Icons.remove_red_eye_rounded, obscureText: true, controller: ctrlPass),
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: ButtonBase('Iniciar Sesión', () => {}),
                          ),
                          InkWell(
                            onTap: (){},
                            child: Align(
                              alignment: Alignment.center,
                              child: TextBase('¿Se te olvido la contraseña?')
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}