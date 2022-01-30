import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Model/User.dart';

class RequestsWidget extends StatelessWidget {
  final BuildContext context;
  final List<User> users;
  final String au;
  final List<User> currentFriends;
  final List<User> requests;

  const RequestsWidget({
    this.context,
    this.users,
    this.au,
    this.currentFriends,
    this.requests,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Requests")),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) => requestTile(
            index: index,
            users: users,
            context: context,
            requests: requests,
            currentfriends: currentFriends,
            au: au),
      ),
    );
  }
}

Widget requestTile({
  int index,
  var users,
  BuildContext context,
  var currentfriends,
  var requests,
  var au,
}) {
  void requestHandler(index) {
// adds accepted user in friendList
    var friends = [];
    currentfriends.add(requests[index]);
    for (final us in currentfriends) {
      friends.add(us.userID);
    }
    FirebaseFirestore.instance
        .collection('users')
        .doc(au)
        .update({"friendsList": friends});
    //removes request from requests
    requests.removeWhere((item) => item == requests[index].userID);
    List request = [];
    for (final req in requests) {
      request.add(req.userID);
    }
    request.remove(requests[index].userID);
    FirebaseFirestore.instance
        .collection('users')
        .doc(au)
        .update({"requests": request});
    // adds your userID in friends friendList
    var usersFriendsList = [];
    for (final x in users) {
      if (x == requests[index]) usersFriendsList = x.friendsList;
    }
    if (!usersFriendsList.contains(au)) usersFriendsList.add(au);
    FirebaseFirestore.instance
        .collection('users')
        .doc(requests[index].userID)
        .update({"friendsList": usersFriendsList});

    Navigator.of(context).pop();
  }

  return Container(
    margin: EdgeInsets.only(top: 20),
    alignment: Alignment.center,
    child: GestureDetector(
      onTap: () => requestHandler(index),
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
                trailing: Text(requests[index].nativeLanguage),
                title: Text(requests[index].displayName),
                subtitle: Text("Accept Request"),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 10,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(requests[index].photoURL),
            ),
          ),
        ],
      ),
    ),
  );
}
