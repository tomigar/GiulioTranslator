import 'package:translator_app/widgets/Chat/Model/User.dart';
import 'package:flutter/material.dart';
import '../MessagesWidget.dart';
import '../NewMessageWidget.dart';
import '../ProfieHeaderWIdget.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          color: Color.fromRGBO(139, 143, 255, 1),
          child: SafeArea(
            child: Column(
              children: [
                ProfileHeaderWidget(name: widget.user.displayName),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: MessagesWidget(idUser: widget.user.userID),
                  ),
                ),
                NewMessageWidget(idUser: widget.user.userID)
              ],
            ),
          ),
        ),
      );
}
