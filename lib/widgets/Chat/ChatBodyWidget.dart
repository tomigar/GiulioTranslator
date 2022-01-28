import 'package:firebase_auth/firebase_auth.dart' as aut;
import 'package:flutter/material.dart';
import 'Model/User.dart';
import 'Page/ChatPage.dart';

class ChatBodyWidget extends StatelessWidget {
  final aut.FirebaseAuth auth = aut.FirebaseAuth.instance;
  final List<User> users;

  ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  List<User> getCurrentUserFriendsList() {
    List<User> currentFriendsL = [];
    var currentFriends;
    for (final friends in users) {
      if (friends.userID == auth.currentUser.uid) {
        currentFriends = friends.friendsList;
      }
    }
    for (final user in users) {
      for (int i = 0; i < currentFriends.length; i++) {
        if (user.userID == currentFriends[i]) {
          currentFriendsL.add(user);
        }
      }
    }
    return currentFriendsL;
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(context),
        ),
      );

  Widget buildChats(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    if (getCurrentUserFriendsList().length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            Text("add user"),
          ],
        ),
      );
    }
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: getCurrentUserFriendsList().length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    width: _size.width * 0.8,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: _size.width * 0.1),
                        trailing: Text(
                            getCurrentUserFriendsList()[index].nativeLanguage),
                        title: Text(
                            getCurrentUserFriendsList()[index].displayName),
                        subtitle: Text("lastCHat"),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(
                                user: getCurrentUserFriendsList()[index]),
                          ));
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 10,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          getCurrentUserFriendsList()[index].photoURL),
                    ),
                  ),
                ],
              ));
        });
  }
}
