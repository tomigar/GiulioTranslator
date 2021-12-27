import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/widgets/profileInfo.dart';

import '../authentication_service.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Drawer(
      elevation: 20,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.1,
                      0.5,
                      1,
                    ],
                    colors: [
                      Color.fromARGB(249, 58, 89, 244),
                      Color.fromARGB(249, 58, 89, 244),
                      Color.fromARGB(0, 58, 89, 244),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: statusBarHeight),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Menu",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    (firebaseUser != null) ? ProfileInfo() : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          (firebaseUser != null)
              ? ElevatedButton(
                  onPressed: () {
                    Provider.of<AuthenticationService>(context, listen: false)
                        .signOut();
                    Navigator.pop(context);
                  },
                  child: Text("signout"),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
