import 'package:flutter/material.dart';
import 'package:healing/Model/MessageChat.dart';

class ContentMessage extends StatelessWidget {
  MessageChat messageChat;
  Color textColor;
  Color contentColor;
  bool isSend;
  ContentMessage(this.messageChat, this.textColor, this.contentColor,
      {this.isSend = false});
  @override
  Widget build(BuildContext context) {
    return (messageChat.type == 0)
        ? Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .6),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: contentColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: isSend ? Radius.zero : Radius.circular(25),
                  topLeft: isSend ? Radius.circular(25) : Radius.zero),
            ),
            child: Text(
              "${messageChat.content}",
              style: Theme.of(context).textTheme.bodyMedium?.apply(
                    color: textColor,
                  ),
            ),
          )
        : (messageChat.type == 1)
            ? Container(
                child: Image.network(
                messageChat.content!,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ))
            : Container(
                child: Image.asset(
                'assets/stickers/${messageChat.content}.png',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ));
  }
}
