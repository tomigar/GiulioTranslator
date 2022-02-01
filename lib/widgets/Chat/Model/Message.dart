import 'package:flutter/material.dart';

import '../utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String idUser;
  final String urlAvatar;
  final String message;
  final String translatedMessage;
  final DateTime createdAt;

  const Message({
    @required this.idUser,
    @required this.urlAvatar,
    @required this.message,
    @required this.translatedMessage,
    @required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        idUser: json['idUser'],
        urlAvatar: json['urlAvatar'],
        message: json['message'],
        translatedMessage: json['translatedMessage'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'urlAvatar': urlAvatar,
        'message': message,
        'translatedMessage': translatedMessage,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
