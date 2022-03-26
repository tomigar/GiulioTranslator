import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Stream<QuerySnapshot>> getdata(chatRoomId) async {
  return FirebaseFirestore.instance
      .collection("users")
      .where("userID", isEqualTo: auth.currentUser.uid)
      .snapshots();
}

FirebaseAuth auth = FirebaseAuth.instance;

String myId = auth.currentUser.uid;
String myUsername = auth.currentUser.uid;
Future<String> myUrlAvatar;
