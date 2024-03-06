import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/home/home_user.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';

class Home extends StatefulWidget {
  final String profileId;

  const Home({super.key, required this.profileId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> future;
  @override
  void initState() {
    super.initState();
    future = userDB.doc(widget.profileId).get();
  }

  @override
  Widget build(BuildContext context) {
    return HomeUser(
      future: future,
    );
  }
}
