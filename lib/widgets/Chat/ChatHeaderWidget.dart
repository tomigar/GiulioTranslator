import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as aut;
import 'package:translator_app/widgets/Chat/RequestsWidget.dart';
import 'package:translator_app/widgets/Chat/SearchUsers.dart';
import 'Model/User.dart';

class ChatHeaderWidget extends StatelessWidget {
  final aut.FirebaseAuth auth = aut.FirebaseAuth.instance;
  final List<User> users;

  ChatHeaderWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  List<User> getCurrentUserFriendsList() {
    List<User> currentFriendsL = [];
    var currentFriends = [];
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

  List<User> getCurrentUserRequests() {
    List<User> currentUserR = [];
    var currentRequests = [];
    for (final req in users) {
      if (req.userID == auth.currentUser.uid) {
        currentRequests = req.requests;
      }
    }
    for (final user in users) {
      for (int i = 0; i < currentRequests.length; i++) {
        if (user.userID == currentRequests[i]) {
          currentUserR.add(user);
        }
      }
    }
    return currentUserR;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserFriendsList();
    getCurrentUserRequests();
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchUsers(
                      context: context,
                      users: users,
                      au: auth.currentUser.uid,
                      currentFriendsList: getCurrentUserFriendsList(),
                    ),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(100, 100, 100, .2),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)),
                ),
              ),
              icon: Icon(Icons.search),
              label: Text("Search"),
            ),
          ),
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(100, 100, 100, .2),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)))),
              child: Column(
                children: [
                  Icon(Icons.location_on_outlined),
                  // Text(
                  //   "Nearby",
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RequestsWidget(
                      context: context,
                      au: auth.currentUser.uid,
                      requests: getCurrentUserRequests(),
                      currentFriends: getCurrentUserFriendsList(),
                      users: users,
                    ),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(100, 100, 100, .2),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              child: Column(
                children: [
                  (getCurrentUserRequests().length != 0)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border_outlined),
                  // Text(
                  //   "Request",
                  //   textAlign: TextAlign.center,
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
