import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String displayName;
  final String email;
  final String boi;
  final String photoUrl;
  final int score;
  final String tolov;

  final bool admin;

  User({
    required this.id,
    required this.tolov,
    required this.score,
    required this.username,
    required this.displayName,
    required this.email,
    required this.boi,
    required this.photoUrl,
    required this.admin,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      username: doc['username'],
      displayName: doc['displayName'],
      email: doc['email'],
      boi: doc['bio'],
      photoUrl: doc['photoUrl'],
      score: doc['score'],
      tolov: doc['tolov'],
      admin: doc['admin'],
    );
  }
}
