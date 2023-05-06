import 'package:flutter/material.dart';
import 'package:healing/Common/TransitionApp.dart';
import 'package:healing/Common/Validate.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Values/ColorsApp.dart';
import 'package:healing/Widgets/TextBase.dart';

class HomePage extends StatefulWidget {

  User user;
  Count count;

  HomePage(this.user, this.count);

  @override
  State<StatefulWidget> createState() => HomePageState(user, count);

}
class HomePageState extends State<HomePage> {

  User user;
  Count count;

  HomePageState(this.user, this.count);

  @override
  void initState() {
    User().getUserServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Healing"),
        actions: [
          IconButton(
            onPressed: () => closeSession(context),
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: SafeArea(
        child: TextBase('Bienvenidos a HEALING', color: Colors.white, size: 40,),
      ),
    );
  }

  // Delete count and user for the State
  closeSession(BuildContext context) async{
    if(await Validate.deleteUserAndCount(count, user)) {
      TransitionApp.goMain(context);
    }
  }

}