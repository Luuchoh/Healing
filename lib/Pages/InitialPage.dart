import 'package:flutter/material.dart';
import 'package:healing/Pages/LoginPage.dart';
import 'package:healing/Values/ColorsApp.dart';
import 'package:healing/Widgets/ButtonBase.dart';
import 'package:healing/Widgets/TextBase.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/bgInitial.png',
              ),
              fit: BoxFit.fitWidth,
              opacity: .6
              ),
            color: Colors.black
            ),
          height: double.infinity,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/logo.png'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonBase("login", () => goToLogin(context)),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextBase('¿No tienes una cuenta?'),
                              TextBase(' Crear Cuenta', color: primaryColor,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // redirection to Login
  goToLogin (BuildContext context) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}