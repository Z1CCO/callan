import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsClass {
  final String userId;
  final String username;
  final String avatar;
  final String message;
  final Timestamp timestamp;

  ChatsClass(
      {required this.userId,
      required this.username,
      required this.avatar,
      required this.message,
      required this.timestamp});
  factory ChatsClass.fromDocument(DocumentSnapshot doc) {
    return ChatsClass(
      userId: doc['userId'],
      username: doc['username'],
      avatar: doc['avatar'],
      message: doc['message'],
      timestamp: doc['timestamp'],
    );
  }
}
