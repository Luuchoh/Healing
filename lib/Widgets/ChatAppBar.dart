import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healing/Common/DateFormatApp.dart';
import 'package:healing/DataBase/Firebase.dart';
import 'package:healing/Model/User.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {

  User peer;
  ChatAppBar(this.peer);

  @override
  State<StatefulWidget> createState() => ChatAppBarState(this.peer);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class ChatAppBarState extends State<ChatAppBar> {

  User peer;
  ChatAppBarState(this.peer);
  StreamSubscription<DatabaseEvent>? onChangeSubs;

  @override
  void initState() {
    onChangeSubs = Firebase.tableUser
        .orderByKey()
        .equalTo(peer.id)
        .onChildChanged
        .listen(onEntryChange);
    super.initState();
  }

  onEntryChange(DatabaseEvent event) async {
    User newUser = User.toUser(event.snapshot);
    if (mounted)
      setState(() {
        peer = newUser;
      });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      iconTheme: IconThemeData(color: Colors.black54),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: CircleAvatar(
                radius: 17,
                backgroundImage: AssetImage('assets/images/logo.png'),
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  peer.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  peer.isOnline == 1
                      ? "Online"
                      : DateFormatApp.getDateFormat(peer.lastTime!),
                  style: Theme.of(context).textTheme.titleMedium?.apply(
                        color: Colors.green,
                      ),
                )
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }
}
