import 'package:flutter/material.dart';

import 'Model/Message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageWidget({
    @required this.message,
    @required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(18);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!isMe)
          CircleAvatar(
              radius: 16, backgroundImage: NetworkImage(message.urlAvatar)),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(3),
          constraints: BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            color: isMe ? Colors.deepPurple[400] : Colors.grey,
            borderRadius: isMe
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.translatedMessage,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: isMe ? TextAlign.start : TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            message.message,
            style: TextStyle(color: isMe ? Colors.black : Colors.black),
            textAlign: isMe ? TextAlign.start : TextAlign.start,
          ),
        ],
      );
}
