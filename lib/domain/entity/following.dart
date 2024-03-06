import 'package:cloud_firestore/cloud_firestore.dart';

class FollowingClass {
  final String username;
  final String ownerId;
  final String userId;
  final String userAvatar;
  final Timestamp timestamp;

  FollowingClass({
    required this.username,
    required this.ownerId,
    required this.userId,
    required this.userAvatar,
    required this.timestamp,
  });

  factory FollowingClass.fromDocument(DocumentSnapshot doc) {
    return FollowingClass(
      ownerId: doc['ownerId'],
      userId: doc['userId'],
      username: doc['username'],
      userAvatar: doc['userAvatar'],
      timestamp: doc['timestamp'],
    );
  }
}
