

import 'package:healing/DataBase/Firebase.dart';

class MessageChat {
  String? id;
  String? content;
  String? idFrom;
  String? idTo;
  String? timestamp;
  int? type;
  bool? seen;

  MessageChat(
      {this.id = '',
        this.content = '',
        this.idFrom = '',
        this.idTo = '',
        this.timestamp = '1612520639893',
        this.type = 0,
        this.seen = false });

  Map<String, dynamic> toMap() {
    return {
      'id': timestamp,
      'content': content,
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'type': type,
      'seen': seen
    };
  }

  MessageChat.toMessage(var snap) {
    id = snap.key;
    content = snap.value['content'];
    idFrom = snap.value['idFrom'];
    idTo = snap.value['idTo'];
    timestamp = snap.value['timestamp'];
    type = snap.value['type'];
    seen = snap.value['seen'];
  }

  save(String groupChatId) {
    Firebase.tableMessage.child(groupChatId).child(timestamp!).set(toMap());
  }

  update(String groupChatId) async{
    await Firebase.tableMessage.child(groupChatId).child(id!).update({'seen': seen});
  }

}