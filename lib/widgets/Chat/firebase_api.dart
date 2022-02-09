import 'package:cloud_firestore/cloud_firestore.dart';
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

    final newMessage = Message(
      idUser: myId,
      urlAvatar: myUrlAvatar,
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
}
