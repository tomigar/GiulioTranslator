import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<Stream<QuerySnapshot>> getdata(chatRoomId) async {
//   return FirebaseFirestore.instance
//       .collection("users")
//       .where("userID", isEqualTo: auth.currentUser.uid)
//       .snapshots();
// }
FirebaseAuth auth = FirebaseAuth.instance;

String myId = auth.currentUser.uid;
String myUsername = auth.currentUser.uid;
String myUrlAvatar =
    'https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png';
