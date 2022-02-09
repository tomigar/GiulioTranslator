import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:translator_app/widgets/Chat/data.dart';
import 'Model/User.dart';

class NearbyUsers extends StatefulWidget {
  final List<User> users;
  final List<User> currentFriendsList;

  NearbyUsers({
    this.users,
    this.currentFriendsList,
    Key key,
  }) : super(key: key);

  @override
  State<NearbyUsers> createState() => _NearbyUsersState();
}

class _NearbyUsersState extends State<NearbyUsers> {
  List<User> nearby = [];
  bool opened = true;

  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  _getCurrentLocation() async {
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(
        () {
          _currentPosition = position;
          FirebaseFirestore.instance
              .collection("users")
              .doc(auth.currentUser.uid)
              .update(
            {
              "lastLocation": [
                _currentPosition.latitude,
                _currentPosition.longitude
              ]
            },
          );
        },
      );

      return _currentPosition;
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getNearby() {
    for (final user in widget.users) {
      var loc = user.lastLocation;
      if (calculateDistance(loc[0], loc[1], _currentPosition.latitude,
                  _currentPosition.longitude) <=
              1 &&
          !nearby.contains(user) &&
          user.userID != auth.currentUser.uid) nearby.add(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (opened) {
      _getCurrentLocation();
      opened = false;
    }
    if (_currentPosition != null) getNearby();
    return Scaffold(
      appBar: AppBar(title: Text("Search Nearby")),
      body: Container(
        child: (nearby.isNotEmpty)
            ? ListView.builder(
                itemCount: nearby.length,
                itemBuilder: (context, index) => userTile(
                    index: index,
                    users: nearby,
                    friends: widget.currentFriendsList,
                    context: context,
                    au: auth.currentUser.uid),
              )
            : Center(child: Text("Searching...")),
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
