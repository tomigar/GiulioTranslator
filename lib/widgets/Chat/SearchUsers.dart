import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:translator_app/widgets/Chat/data.dart';

import 'Model/User.dart';

class SearchUsers extends StatefulWidget {
  final BuildContext context;
  final List<User> users;
  final List<User> currentFriendsList;
  final String au;

  SearchUsers({
    this.context,
    this.users,
    this.currentFriendsList,
    this.au,
  });

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  List<User> _foundUsers = [];

  @override
  Widget build(BuildContext context) {
    @override
    // This function is called whenever the text field changes
    void _runFilter(String enteredKeyword) {
      widget.users
          .removeWhere((element) => element.userID == auth.currentUser.uid);
      List<User> results = [];
      if (enteredKeyword.isNotEmpty) {
        results = widget.users
            .where((user) => user.displayName
                .toLowerCase()
                .startsWith(enteredKeyword.toLowerCase()))
            .toList();
        // we use the toLowerCase() method to make it case-insensitive
      }
      // Refresh the UI
      setState(() {
        _foundUsers = results;
      });
    }

    var usersList = [];
    for (final us in widget.users) {
      if (us.userID != widget.au) {
        usersList.add(us);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          autofocus: true,
          onChanged: (val) => _runFilter(val),
          decoration: InputDecoration(hintText: "Search"),
        ),
      ),
      body: ListView.builder(
        itemCount: _foundUsers.length,
        itemBuilder: (context, index) => userTile(
          index: index,
          users: _foundUsers,
          friends: widget.currentFriendsList,
          context: context,
          au: widget.au,
        ),
      ),
    );
  }
}

Widget userTile({
  int index,
  var users,
  var friends,
  BuildContext context,
  String au,
}) {
  //gets friends List
  var frind = [];
  for (final fr in friends) {
    frind.add(fr.userID);
  }
  return Container(
    margin: EdgeInsets.only(top: 20),
    alignment: Alignment.center,
    child: IndexedSemantics(
      index: 1,
      child: GestureDetector(
        onTap: () {
          if (!frind.contains(users[index].userID)) {
            var requests = users[index].requests;
            if (!requests.contains(au)) {
              requests.add(au);
            }
            FirebaseFirestore.instance
                .collection('users')
                .doc(users[index].userID)
                .update({"requests": requests});
            Navigator.of(context).pop();
          }
        },
        onLongPress: () {
          var requests;
          requests = users[index].requests;
          requests.remove(au);
          FirebaseFirestore.instance
              .collection('users')
              .doc(users[index].userID)
              .update({"requests": requests});
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
                    subtitle: (frind.contains(users[index].userID))
                        ? Text("Friends")
                        : Text("Add User")),
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


// onTap: () {
//           if (!friend.contains(users[index].userID)) {
//             friend.add(users[index].userID);
//           }
//           FirebaseFirestore.instance
//               .collection('users')
//               .doc(au)
//               .update({"friendsList": friend});
//           Navigator.of(context).pop();
//         },
//         onLongPress: () {
//           friend.removeWhere((item) => item == users[index].userID);
//           FirebaseFirestore.instance
//               .collection('users')
//               .doc(au)
//               .update({"friendsList": friend});
//           Navigator.of(context).pop();