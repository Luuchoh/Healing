import 'package:flutter/material.dart';
import 'package:healing/Common/TransitionApp.dart';
import 'package:healing/Common/Validate.dart';
import 'package:healing/HttpProtocol/Status.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Pages/LoginPage.dart';
import 'package:healing/Widgets/BarHealing.dart';
import 'package:healing/Widgets/ButtonBase.dart';
import 'package:healing/Widgets/DropDownBase.dart';
import 'package:healing/Widgets/ProgressDialog.dart';
import 'package:healing/Widgets/SnackBarApp.dart';
import 'package:healing/Widgets/TextBase.dart';
import 'package:healing/Widgets/TextFormFieldBase.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();
  TextEditingController ctrlConfirm = TextEditingController();
  String dropdownValue = '';
  List<String> list = <String>['Paciente', 'Médico'];

  @override
  void initState() {
    dropdownValue = list.first;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height * 1.30;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: screenHeight, maxHeight: double.infinity),
            child: Stack(
              children: [
                BarHealing(),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.40,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 45),
                              child: TextBase(
                                'Bienvenido a Healing',
                                size: 20,
                                weight: FontWeight.bold,
                              ),
                            ),
                            TextFormFieldBase(
                              'Nombre',
                              Icons.person,
                              controller: ctrlName,
                              validator: validateName,
                              keyboardType: TextInputType.name,
                            ),
                            TextFormFieldBase(
                              'Email',
                              Icons.person,
                              controller: ctrlEmail,
                              validator: validateEmail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            DropDownBase(
                              list,
                              Icons.person,
                              dropdownValue,
                              dropDownOnChanged,
                            ),
                            TextFormFieldBase(
                              'Contraseña',
                              Icons.remove_red_eye_rounded,
                              controller: ctrlPass,
                              validator: validatePassword,
                              obscureText: true,
                            ),
                            TextFormFieldBase(
                              'Confirma',
                              Icons.remove_red_eye_rounded,
                              controller: ctrlConfirm,
                              validator: validateConfirm,
                              obscureText: true,
                            ),
                            Padding(
                              padding: EdgeInsets.all(30.0),
                              child: ButtonBase(
                                  'Registrarse', () => signUp(context)),
                            ),
                            InkWell(
                              onTap: () => goToLogin(context),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '¿Tienes una cuenta?',
                                    ),
                                    Text(
                                      ' Iniciar sesión ',
                                      style: TextStyle(
                                          color: Colors.deepPurple[300]),
                                    )
                                  ],
                                ),
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

  signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      showProgress(context);
      var signup =
          await Count().signUp(ctrlEmail.text, ctrlPass.text, ctrlName.text);

      if (Validate.isNotStatus(signup)) {

        var count = await Count().login(ctrlEmail.text, ctrlPass.text);

        if (Validate.isNotStatus(count)) {
          var user = await User().getUserServer();

          if (Validate.isNotStatus(user)) {
            TransitionApp.closePageOrDialog(context);
            TransitionApp.goMain(context, count: count, user: user);
          } else
            error(count, context);
        } else
          error(count, context);
      } else
        error(signup, context);
      // formKey.currentState!.reset();
    }
  }

  // Show Snack bar with error in validation login
  error(Status status, BuildContext context) {
    TransitionApp.closePageOrDialog(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBarApp(Validate.isWrongEmailPassword(status.response)
            ? TextBase(
                "Usuario o Contraseña Incorrecto",
                color: Colors.white,
              )
            : status.statusWidget));
  }

  // Show modal with a loader
  Future<void> showProgress(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProgressDialog();
        });
  }

  // Redirection to Login Page
  goToLogin(BuildContext context) {
    TransitionApp.openPage(context, LoginPage());
  }

  // Perform validation on name field
  validateName(String? value) {
    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return 'Nombre necesario';
    }
    if (!regExp.hasMatch(value.toString())) {
      return 'Nombre invalido';
    }
    return null;
  }

  // Perform validation on email field
  validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
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
  validatePassword(String? value) {
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$';
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return 'Contraseña necesaria';
    }
    if (!regExp.hasMatch(value.toString())) {
      return 'Debe tener 1 minuscula, 1 mayuscula y 1 numero';
    }
    return null;
  }

  // Perform validation on password field
  validateConfirm(String? value) {
    if (value != ctrlPass.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  // Perfom change of the state and set value
  dropDownOnChanged(String? value) {
    // This is called when the user selects an item.
    setState(() {
      dropdownValue = value!;
    });
  }
}
