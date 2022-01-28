import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Model/User.dart';

class SearchUsers extends StatelessWidget {
  final BuildContext context;
  final List<User> users;
  final String au;
  final List<User> currentFriends;
  SearchUsers({
    this.context,
    this.users,
    this.au,
    this.currentFriends,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var friend = [];
    for (var i in currentFriends) {
      friend.add(i.userID);
    }
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          autofocus: true,
          decoration: InputDecoration(hintText: "Search"),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => userTile(
            index: index,
            users: users,
            context: context,
            friend: friend,
            au: au),
      ),
    );
  }
}

Widget userTile({
  int index,
  var users,
  BuildContext context,
  var friend,
  var au,
}) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    alignment: Alignment.center,
    child: IndexedSemantics(
      index: 1,
      child: GestureDetector(
        onTap: () {
          if (!friend.contains(users[index].userID)) {
            friend.add(users[index].userID);
          }
          FirebaseFirestore.instance
              .collection('users')
              .doc(au)
              .update({"friendsList": friend});
          Navigator.of(context).pop();
        },
        onLongPress: () {
          friend.removeWhere((item) => item == users[index].userID);
          FirebaseFirestore.instance
              .collection('users')
              .doc(au)
              .update({"friendsList": friend});
          Navigator.of(context).pop();
        },
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 50),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  trailing: Text(users[index].nativeLanguage),
                  title: Text(users[index].displayName),
                  subtitle: Text("Created 10.8.2002"),
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 10,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(users[index].photoURL),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
