import 'package:flutter/material.dart';
import 'package:healing/Common/TransitionApp.dart';
import 'package:healing/Widgets/ButtonBase.dart';
import 'package:healing/Widgets/TextFormFieldBase.dart';

class ResetPasswordDialog extends StatelessWidget {

  TextEditingController ctrlEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormFieldBase("Correo", Icons.email_outlined, controller: ctrlEmail,),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ButtonBase(
                    "Cancelar",
                    () => close(context),
                    width: (MediaQuery.of(context).size.width - 140) * 0.45,
                    letterSpacing: 1,
                    fontSize: 14,
                  ),
                  ButtonBase(
                    "Restablecer",
                    () => reset(),
                    width: (MediaQuery.of(context).size.width - 140) * 0.5,
                    letterSpacing: 1,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  close(BuildContext context) {
    TransitionApp.closePageOrDialog(context);
  }

  reset() {

  }

}