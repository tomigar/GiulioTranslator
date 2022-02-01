import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Stream<QuerySnapshot>> getdata(chatRoomId) async {
  return FirebaseFirestore.instance
      .collection("users")
      .where("userID", isEqualTo: auth.currentUser.uid)
      .snapshots();
}

String myId = auth.currentUser.uid;
String myUsername = auth.currentUser.uid;
String myUrlAvatar = 'https://i.imgur.com/GXoYikT.png';

FirebaseAuth auth = FirebaseAuth.instance;
// Christine

// Napoleon
// String myId = 'YB0XmxZ7KiZTHGtGRpue';
// String myUsername = 'Tomáš';
// String myUrlAvatar =
//     'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/President_Barack_Obama.jpg/480px-President_Barack_Obama.jpg';
