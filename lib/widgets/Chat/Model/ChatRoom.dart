import 'package:flutter/material.dart';

class ChatRoom {
  final String chatRoomID;
  final List usersID;
  final String lastText;

  const ChatRoom({
    @required this.chatRoomID,
    @required this.usersID,
    @required this.lastText,
  });

  static ChatRoom fromJson(Map<String, dynamic> json) => ChatRoom(
        chatRoomID: json['idUser'],
        usersID: json['urlAvatar'],
        lastText: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'idUser': chatRoomID,
        'urlAvatar': usersID,
        'message': lastText,
      };
}
