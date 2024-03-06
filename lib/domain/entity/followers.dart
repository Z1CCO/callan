import 'package:cloud_firestore/cloud_firestore.dart';

class FollowersClass {
  final String username;
  final String ownerId;
  final String userId;
  final String userAvatar;
  final Timestamp timestamp;

  FollowersClass({
    required this.username,
    required this.ownerId,
    required this.userId,
    required this.userAvatar,
    required this.timestamp,
  });

  factory FollowersClass.fromDocument(DocumentSnapshot doc) {
    return FollowersClass(
      ownerId: doc['ownerId'],
      userId: doc['userId'],
      username: doc['username'],
      userAvatar: doc['userAvatar'],
      timestamp: doc['timestamp'],
    );
  }
}
