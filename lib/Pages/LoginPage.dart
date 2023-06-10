import 'package:flutter/material.dart';
import 'package:healing/Common/TransitionApp.dart';
import 'package:healing/Common/Validate.dart';
import 'package:healing/HttpProtocol/Status.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Widgets/BarHealing.dart';
import 'package:healing/Widgets/ButtonBase.dart';
import 'package:healing/Widgets/ProgressDialog.dart';
import 'package:healing/Widgets/ResetPasswordDialog.dart';
import 'package:healing/Widgets/SnackBarApp.dart';
import 'package:healing/Widgets/TextBase.dart';
import 'package:healing/Widgets/TextFormFieldBase.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage>{

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 45),
                              child: TextBase('Bienvenido a Healing', size: 20, weight: FontWeight.bold,),
                            ),
                            TextFormFieldBase('Usuario', Icons.person, controller: ctrlEmail, validator: validateEmail, keyboardType: TextInputType.emailAddress,),
                            TextFormFieldBase('Contraseña', Icons.remove_red_eye_rounded, obscureText: true, controller: ctrlPass, validator: validatePassword,),
                            Padding(
                              padding: EdgeInsets.all(30.0),
                              child: ButtonBase('Iniciar Sesión', () => login(context)),
                            ),
                            InkWell(
                              onTap: () => resetPassword(context),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Perform validation on email field
  validateEmail (String? value) {
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return 'Correo necesario';
    }
    if (!regExp.hasMatch(value.toString())) {
      return 'Correo invalido';
    }
    return null;
  }

  // Perform validation on password field
  validatePassword (String? value) {
    if (value?.length == 0) {
      return 'Contraseña necesaria';
    }
    return null;
  }

  // Perform Login
  login(BuildContext context) async{
    if (formKey.currentState!.validate()) {
      // formKey.currentState!.reset();
      showProgress(context);
      var count = await Count().login(ctrlEmail.text, ctrlPass.text);

      if(Validate.isNotStatus(count)){
        var user = await User().getUserServer();
        if(Validate.isNotStatus(user)){
          var userFirebase = await User.getUserFirebase(user.id);
          TransitionApp.closePageOrDialog(context);
          TransitionApp.goMain(context, count: count, user: userFirebase);
        } else
          error(count, context);
      } else
        error(count, context);
    }
  }

  // Show Snack bar with error in validation login
  error(Status status,BuildContext context) {
    TransitionApp.closePageOrDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarApp(
        Validate.isWrongEmailPassword(status.response)
            ? TextBase("Usuario o Contraseña Incorrecto", color: Colors.white,)
            : status.statusWidget
    ));
  }

  // Show modal with a loader
  Future<void> showProgress(BuildContext context) async{
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProgressDialog();
        }
    );
  }

  Future<void> resetPassword(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context){
      return ResetPasswordDialog();
    }
    );
  }

}