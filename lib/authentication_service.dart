import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

 
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      print('chyba v prihlaseni');
      return e.message;
    }
  }

  
  Future<String> signUp(
      {String email,
      String password,
      String nickname,
      String nativeLanguage,
      BuildContext ctx}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        FirebaseFirestore.instance
            .collection('UserData')
            .doc(value.user.uid)
            .set({
          "nickname": nickname,
          "email": value.user.email,
          "nativeLanguage": nativeLanguage,
        });
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
    try{
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
        FirebaseFirestore.instance
            .collection('UserData')
            .doc(value.user.uid)
            .set({
          "nickname": value.user.displayName,
          "email": value.user.email,
          "photo": value.user.photoURL,
        },);
        
        },);
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  // Trigger the authentication flow
  
}
}
