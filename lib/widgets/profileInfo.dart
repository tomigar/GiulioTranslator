import 'package:firebase_auth/firebase_auth.dart' as aut;
import 'package:flutter/material.dart';

import 'Chat/Model/User.dart';
import 'Chat/firebase_api.dart';

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

  @override
  Widget build(BuildContext context) {
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
                    // Navigator.of(context).pushNamed('/profile/edit-profile');
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
                          // Container(
                          //   width: 100,
                          //   height: 100,
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: Theme.of(context).backgroundColor),
                          // ),
                          Container(
                            width: _size.width * .8,
                            child: Container(
                              child: Text(
                                users[getCurrentUser(users)].displayName ??
                                    Container(),
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
