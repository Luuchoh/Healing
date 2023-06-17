import 'package:flutter/material.dart';

import 'package:healing/Helpers/helpers.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Pages/ChatPage.dart';

import 'package:healing/Values/ColorsApp.dart';

class ButtonChat extends StatelessWidget {
  User user, peer;
  Count count;

  ButtonChat(this.user, this.peer, this.count);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.chat_rounded,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                navegarMapaFadeIn(context, ChatPage(user, peer, count)));
          },
        ),
      ),
    );
  }
}
