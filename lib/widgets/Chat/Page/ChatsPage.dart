import 'package:flutter/material.dart';
import 'package:translator_app/widgets/Chat/Model/User.dart';

import '../ChatBodyWidget.dart';
import '../ChatHeaderWidget.dart';
import '../firebase_api.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: StreamBuilder<List<User>>(
          stream: FirebaseApi.getUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return buildText('Something Went Wrong Try later');
                } else {
                  final users = snapshot.data;
                  if (users.isEmpty) {
                    return buildText('No Users Found');
                  } else
                    return Container(
                      color: Color.fromRGBO(139, 143, 255, 1),
                      child: Column(
                        children: [
                          ChatHeaderWidget(users: users),
                          ChatBodyWidget(
                            users: users,
                            // chatRooms: getChats(),
                          )
                        ],
                      ),
                    );
                }
            }
          },
        ),
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
