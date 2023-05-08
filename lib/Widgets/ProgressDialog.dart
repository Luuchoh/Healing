import 'package:flutter/material.dart';
import 'package:healing/Values/ColorsApp.dart';
import 'package:healing/Widgets/TextBase.dart';

class ProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SimpleDialog(
        children: [
          Center(
            child: Column(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color> (primaryColor),
                ),
                TextBase('Por favor espere...'),
              ],
            ),
          ),
        ],
      ),
      onWillPop: () async => false
    );
  }

}