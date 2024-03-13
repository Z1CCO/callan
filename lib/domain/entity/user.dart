import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final int score;
  final String tolov;
  final String group;
  final bool admin;
  final bool teacher;

  User({
    required this.id,
    required this.tolov,
    required this.score,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.admin,
    required this.teacher,
    required this.group,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      username: doc['username'],
      email: doc['email'],
      group: doc['group'],
      photoUrl: doc['photoUrl'],
      score: doc['score'],
      tolov: doc['tolov'],
      admin: doc['admin'],
      teacher: doc['teacher'],
    );
  }
}
