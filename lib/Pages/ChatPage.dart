import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healing/Common/Keys.dart';
import 'package:healing/DataBase/Firebase.dart';
import 'package:healing/Model/MessageChat.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Widgets/ChatAppBar.dart';
import 'package:healing/Widgets/ReceivedMessage.dart';
import 'package:healing/Widgets/SentMessage.dart';
import 'package:healing/Widgets/StickerGridView.dart';
import 'package:healing/Widgets/TextFieldChat.dart';

class ChatPage extends StatefulWidget {
  User? user;
  User? peer;

  ChatPage({this.user, this.peer}) : super(key: chatState);

  @override
  State createState() => ChatState(user!, peer!);
}

class ChatState extends State<ChatPage> {
  User user;
  User peer;

  ChatState(this.user, this.peer);

  String groupChatId = "";
  int _limit = 20;
  final int _limitIncrement = 20;

  bool isShowSticker = false;

  final ScrollController listScrollController = ScrollController();

  final TextEditingController textEditingController = TextEditingController();
  List<MessageChat> messages = [];

  StreamSubscription<DatabaseEvent>? onAddedSubs;
  StreamSubscription<DatabaseEvent>? onChangeSubs;

  @override
  void initState() {
    super.initState();
    loadGroupChatId();
    listScrollController.addListener(_scrollListener);
    onAddedSubs = getQuery().onChildAdded.listen(onEntryAdded);
    onChangeSubs = getQuery().onChildChanged.listen(onEntryChanged);

  }

  Query getQuery() {
    return Firebase.tableMessage
        .child(groupChatId)
        .orderByChild('timestamp')
        .limitToLast(_limit);
  }

  onEntryAdded(DatabaseEvent event) async {
    MessageChat messageChat = await updateSeen(event.snapshot);
    setState(() {
      messages.add(messageChat);
      messages..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    });
  }

  onEntryChanged(DatabaseEvent event) async {
    if (mounted) {
      MessageChat oldEntry = messages.singleWhere((entry) {
        return entry.id == event.snapshot.key;
      });

      MessageChat messageChat = await updateSeen(event.snapshot);
      setState(() {
        messages[messages.indexOf(oldEntry)] = messageChat;
        messages..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      });
    }
  }

  updateSeen(DataSnapshot snapshot) async {
    MessageChat messageChat = MessageChat.toMessage(snapshot);
    if (messageChat.idFrom != user.id) {
      messageChat.seen = true;
      await messageChat.update(groupChatId);
    }

    return messageChat;
  }

  loadGroupChatId() async {
    setState(() {
      groupChatId = (user.id.hashCode <= peer.id.hashCode)
          ? '${user.id}-${peer.id}'
          : '${peer.id}-${user.id}';
    });
  }

  _scrollListener() {
    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("llegar al fondo");
      setState(() {
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
        listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("llegar al arriba");
      setState(() {
      });
    }
  }



  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      //user..chattingWith=null..updateChattingWith();
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: ChatAppBar(peer),
        body: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  // List of messages
                  buildListMessage(),
                  (isShowSticker)
                    ? StickerGridView()
                    : SizedBox.shrink(),
                  TextFieldChat(),
                ],
              ),
            ],
          ),
          onWillPop: onBackPress,
        ));
  }

  showSticker (bool isShowSticker) {
    setState(() {
      this.isShowSticker = isShowSticker;
    });
  }

  buildItem(MessageChat messageChat) {
    return (messageChat.idFrom == user.id)
      ? SentMessage(messageChat)
      : ReceivedMessage(messageChat);
  }

  Widget buildListMessage() {
    return Flexible(
        child: groupChatId == ''
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red
                  )
                )
              )
            : ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) => buildItem(messages[index]),
                itemCount: messages.length,
                reverse: true,
                controller: listScrollController,
                )
    );
  }

  void onSendMessage(int type, {String? content}) {
    content = (content == null) ? textEditingController.text : content;
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.isNotEmpty) {
      textEditingController.clear();
      MessageChat(
          seen: false,
          idFrom: user.id,
          idTo: peer.id,
          timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
          content: content,
          type: type)
          .save(groupChatId);

      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

}
