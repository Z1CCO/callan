import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/callan/globaltab.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';

class Callan extends StatefulWidget {
  final String profileId;

  const Callan({super.key, required this.profileId});

  @override
  State<Callan> createState() => _CallanState();
}

class _CallanState extends State<Callan> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> future;
  @override
  void initState() {
    super.initState();
    future = userDB.doc(widget.profileId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 85.0,
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        title: const Text(
          'Top O`quvchilar',
          style: TextStyle(
            fontFamily: 'SingleDay',
            fontSize: 35.0,
            color: Colors.white,
          ),
        ),
      ),
      body: const GlobalTab(),
    );
  }
}
