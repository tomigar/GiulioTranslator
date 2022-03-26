import 'package:firebase_auth/firebase_auth.dart' as aut;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../authentication_service.dart';
import 'Model/User.dart';
import 'Page/ChatPage.dart';

class ChatBodyWidget extends StatelessWidget {
  final aut.FirebaseAuth auth = aut.FirebaseAuth.instance;
  final List<User> users;
  // final Stream<List<ChatRoom>> chatRooms;

  ChatBodyWidget({
    @required this.users,
    // @required this.chatRooms,
    Key key,
  }) : super(key: key);

  List<User> getCurrentUserFriendsList(context) {
    try {
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
    } catch (e) {
      Provider.of<AuthenticationService>(context, listen: false).signOut();

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(chatRooms);
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: buildChats(context),
      ),
    );
  }

  Widget buildChats(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    if (getCurrentUserFriendsList(context).length == 0) {
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
        itemCount: getCurrentUserFriendsList(context).length,
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
                        trailing: Text(getCurrentUserFriendsList(context)[index]
                            .nativeLanguage),
                        title: Text(getCurrentUserFriendsList(context)[index]
                            .displayName),
                        subtitle: Text("Open chat"),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(
                                user:
                                    getCurrentUserFriendsList(context)[index]),
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
                          getCurrentUserFriendsList(context)[index].photoURL),
                    ),
                    //     FutureBuilder(
                    //   future: FirebaseApi().downloadURL(
                    //       getCurrentUserFriendsList(context)[index].userID),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<String> snapshot) {
                    //     if (snapshot.connectionState ==
                    //             ConnectionState.done &&
                    //         snapshot.hasData) {
                    //       return Container(
                    //         width: 60,
                    //         height: 60,
                    //         child: Image.network(
                    //           snapshot.data,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       );
                    //     }
                    //     if (snapshot.connectionState ==
                    //             ConnectionState.waiting ||
                    //         !snapshot.hasData) {
                    //       return CircularProgressIndicator();
                    //     }
                    //     return Container();
                    //   },
                    // )

                    //     CircleAvatar(
                    //   radius: 30,
                    //   backgroundColor: Colors.red,
                    // ),
                  ),
                ],
              ));
        });
  }
}
