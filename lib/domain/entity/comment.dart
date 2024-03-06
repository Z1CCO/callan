import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  final String userId;
  final String username;
  final String avatar;
  final String comment;
  final Timestamp timestamp;

  Comments(
      {required this.userId,
      required this.username,
      required this.avatar,
      required this.comment,
      required this.timestamp});
  factory Comments.fromDocument(DocumentSnapshot doc) {
    return Comments(
      userId: doc['userId'],
      username: doc['username'],
      avatar: doc['avatar'],
      comment: doc['comment'],
      timestamp: doc['timestamp'],
    );
  }
}
