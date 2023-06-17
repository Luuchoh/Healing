import 'package:flutter/material.dart';
import 'package:healing/Common/DateFormatApp.dart';
import 'package:healing/Common/Keys.dart';
import 'package:healing/Model/MessageChat.dart';
import 'package:healing/Widgets/ContentMessage.dart';

class ReceivedMessage extends StatelessWidget {
  MessageChat message;
  ReceivedMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${chatState.currentState!.peer.userName}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ContentMessage(
                      message, Colors.black87, Colors.grey.withOpacity(.3))),
            ],
          ),
          Text(
            "${DateFormatApp.getDateFormat(message.timestamp)}",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.apply(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
