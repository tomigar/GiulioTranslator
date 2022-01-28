import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
// Christine
String myId = auth.currentUser.uid;
String myUsername = auth.currentUser.displayName;
String myUrlAvatar = 'https://i.imgur.com/GXoYikT.png';

// Napoleon
// String myId = 'YB0XmxZ7KiZTHGtGRpue';
// String myUsername = 'Tomáš';
// String myUrlAvatar =
//     'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/President_Barack_Obama.jpg/480px-President_Barack_Obama.jpg';
