import 'package:meta/meta.dart';

import '../utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  final String userID;
  final String displayName;
  final String photoURL;
  final DateTime lastMessageTime;
  final String nativeLanguage;
  final List friendsList;
  final List requests;

  const User({
    this.userID,
    @required this.displayName,
    @required this.photoURL,
    @required this.lastMessageTime,
    this.nativeLanguage,
    this.friendsList,
    this.requests,
  });

  User copyWith({
    String userID,
    String displayName,
    String photoURL,
    String lastMessageTime,
    List friendsList,
    List requests,
  }) =>
      User(
        userID: userID ?? this.userID,
        displayName: displayName ?? this.displayName,
        photoURL: photoURL ?? this.photoURL,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
        nativeLanguage: nativeLanguage ?? this.nativeLanguage,
        friendsList: friendsList ?? this.friendsList,
        requests: requests ?? this.requests,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        userID: json['userID'],
        displayName: json['displayName'],
        photoURL: json['photoURL'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
        nativeLanguage: json['nativeLanguage'],
        friendsList: json['friendsList'],
        requests: json['requests'],
      );

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'displayName': displayName,
        'photoURL': photoURL,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
        'nativeLanguage': nativeLanguage,
        'friendsList': friendsList,
        'requests': requests,
      };
}
