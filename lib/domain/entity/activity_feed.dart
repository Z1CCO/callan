import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityFeed {
  final String username;
  final String userId;
  final String type;
  final String mediaUrl;
  final String postId;
  final String userAvatar;
  final String? commentData;
  final Timestamp timestamp;

  ActivityFeed({
    required this.username,
    required this.userId,
    required this.type,
    required this.mediaUrl,
    required this.postId,
    required this.userAvatar,
    this.commentData = '',
    required this.timestamp,
  });

  factory ActivityFeed.fromDocument(DocumentSnapshot doc) {
    return ActivityFeed(
      postId: doc['postId'],
      userId: doc['userId'],
      username: doc['username'],
      type: doc['type'],
      mediaUrl: doc['mediaUrl'],
      userAvatar: doc['userAvatar'],
      commentData: doc['commentData'] ?? null,
      timestamp: doc['timestamp'],
    );
  }
}
