import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as core;
import 'Model/ChatRoom.dart';
import 'Model/Message.dart';
import 'Model/User.dart';
import 'data.dart';
import 'utils.dart';

class FirebaseApi {
  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static Stream<List<ChatRoom>> getChatRooms() => FirebaseFirestore.instance
      .collection('chats')
      .orderBy(ChatRoomField().lastTextTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(ChatRoom.fromJson));

  static Future uploadMessage(
      String chatID, String message, var translated) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$chatID/messages');
    var dataList = [];

    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) =>
          ((element["userID"] == auth.currentUser.uid)
              ? dataList.add(element)
              : null));
      print(dataList[0]["photoURL"]);
    });

    final newMessage = Message(
      idUser: myId,
      urlAvatar: dataList[0]["photoURL"],
      message: message,
      translatedMessage: translated,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(auth.currentUser.uid)
        .update({UserField.lastMessageTime: DateTime.now()});

    final refChats = FirebaseFirestore.instance.collection('chats');

    await refChats
        .doc(chatID)
        .set({"lastTextTime": DateTime.now(), "lastText": message});
  }

  static Stream<List<Message>> getMessages(String chatID) =>
      FirebaseFirestore.instance
          .collection('chats/$chatID/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> uploadImage(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      await storage.ref('profilePictures/$fileName').putFile(file);
    } on core.FirebaseException catch (e) {
      print(e);
    }
  }

//   Future<ListResult> listFiles() async {
//     ListResult results = await storage.ref('profilePictures').listAll();

//     results.items.forEach((Reference ref) {
//       print('Found file: $ref');
//     });
//     return results;
//   }

  Future<String> downloadURL(String imageName) async {
    String downloadURL =
        await storage.ref('profilePictures/$imageName').getDownloadURL();
    return downloadURL;
  }
}
