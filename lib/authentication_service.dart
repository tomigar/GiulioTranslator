import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:translator_app/widgets/Chat/data.dart';
import 'package:translator_app/widgets/Chat/firebase_api.dart';

import 'widgets/Languages/LanguagesList.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(
      {String email, String password, BuildContext ctx}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          width: double.infinity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          content: Text(
            e.message,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
      return e.message;
    }
  }

  Future<String> signUp(
      {String email,
      String password,
      String nickname,
      String nativeLanguage,
      String path,
      String filename,
      BuildContext ctx}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        FirebaseFirestore.instance.collection('users').doc(value.user.uid).set({
          "userID": value.user.uid,
          "displayName": nickname,
          "photoURL":
              "https://firebasestorage.googleapis.com/v0/b/giulio-translator-app.appspot.com/o/staff-placeholder.jpg?alt=media&token=798181d5-4400-419c-b400-48da752cdf6e",
          "lastMessageTime": DateTime.now(),
          "nativeLanguage": nativeLanguage,
          "friendsList": [],
          "requests": [],
          "lastLocation": [0, 0],
        });
        final FirebaseApi storage = FirebaseApi();
        // storage.uploadImage(path, auth.currentUser.uid).then((value) => storage
        //     .downloadURL(auth.currentUser.uid)
        //     .then((value) => FirebaseFirestore.instance
        //             .collection('users')
        //             .doc(auth.currentUser.uid)
        //             .update({
        //           "photoURL": value,
        //         })));
        Navigator.of(ctx).pop();
      });
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          content: Text(
            e.message,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
      return e.message;
    }
  }

  Future signInWithGoogle(BuildContext ctx) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) async {
          if (value.additionalUserInfo.isNewUser) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(value.user.uid)
                .set(
              {
                "userID": value.user.uid,
                "lastMessageTime": DateTime.now(),
                "nativeLanguage": "",
                "displayName": value.user.displayName,
                "photoURL": value.user.photoURL,
                "friendsList": [],
                "requests": [],
                "lastLocation": [0, 0],
              },
            );
            showDialog(
              context: ctx,
              builder: (context) {
                return languageDialog(ctx);
              },
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    // Trigger the authentication flow
  }
}

Widget languageDialog(ctx) {
  return AlertDialog(
    title: Text("Please set your native language first"),
    content: Container(
      width: 300,
      height: 500,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: languages.length - 1,
        itemBuilder: (context, index) {
          return ListTile(
            enableFeedback: true,
            title: Text(
                //+1 to skip automatically
                languages[index + 1]["name"]),
            onTap: () {
              Navigator.of(context).pop();
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(auth.currentUser.uid)
                  .update(
                {
                  "nativeLanguage": languages[index + 1]["name"],
                },
              );
            },
          );
        },
      ),
    ),
  );
}
