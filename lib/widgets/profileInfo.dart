import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as aut;
import 'package:flutter/material.dart';
import 'package:translator_app/screens/EditProfile.dart';

import 'Chat/Model/User.dart';
import 'Chat/firebase_api.dart';

// ignore: must_be_immutable
class ProfileInfo extends StatelessWidget {
  final aut.FirebaseAuth auth = aut.FirebaseAuth.instance;

  int getCurrentUser(users) {
    int number;
    for (int i = 0; i < users.length; i++) {
      if (users[i].userID == auth.currentUser.uid) {
        number = i;
      }
    }
    return number;
  }

  var dataList = [];

  String photoURL;
  String name;
  String selectedLanguageName;

  getUserInfo() {
    FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) =>
          ((element["userID"] == auth.currentUser.uid)
              ? dataList.add(element)
              : null));
      photoURL = dataList[0]["photoURL"];
      name = dataList[0]["displayName"];
      selectedLanguageName = dataList[0]["nativeLanguage"];
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();
    Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: Colors.transparent,
              height: _size.height * .06,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(32)),
              width: _size.width * .6,
              height: _size.height * .12,
              child: Container(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Icon(Icons.settings),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    overlayColor: MaterialStateProperty.all(Colors.purple[100]),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Scaffold(
                              body: EditProfile(
                                name: name,
                                photoURL: photoURL,
                                selectedLanguageName: selectedLanguageName,
                              ),
                            )));
                  },
                ),
              ),
            ),
          ],
        ),
        Center(
          child: StreamBuilder<List<User>>(
            stream: FirebaseApi.getUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Something Went Wrong Try later');
                  } else {
                    final users = snapshot.data;

                    if (users.isEmpty) {
                      return Text('No Users Found');
                    } else {
                      return Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  users[getCurrentUser(users)].photoURL),
                            ),
                          ),
                          Container(
                            width: _size.width * .8,
                            child: Container(
                              child: Text(
                                users[getCurrentUser(users)].displayName ??
                                    Container(child: Text("Login")),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
              }
            },
          ),
        ),
      ],
    );
  }
}
