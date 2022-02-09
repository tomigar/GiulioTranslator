import 'package:flutter/material.dart';

class ChatRoomField {
  final String lastTextTime = 'lastTextTime';
}

class ChatRoom {
  final String chatRoomID;
  final List usersID;
  final String lastText;
  final DateTime lastTextTime;

  const ChatRoom({
    @required this.chatRoomID,
    @required this.usersID,
    @required this.lastText,
    @required this.lastTextTime,
  });

  static ChatRoom fromJson(Map<String, dynamic> json) => ChatRoom(
        chatRoomID: json['chatRoomID'],
        usersID: json['usersID'],
        lastText: json['lastText'],
        lastTextTime: json['lastTextTime'],
      );

  Map<String, dynamic> toJson() => {
        'chatRoomID': chatRoomID,
        'usersID': usersID,
        'lastText': lastText,
        'lastTextTime': lastTextTime,
      };
}
