import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/activity/isadmin_user.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';

class IsAdmin extends StatefulWidget {
  const IsAdmin({super.key});

  @override
  State<IsAdmin> createState() => _IsAdminState();
}

class _IsAdminState extends State<IsAdmin> {
  Future<List> getActivityuser() async {
    final snapshot = await userDB.get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getActivityuser(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List users =
            snapshot.data.map((doc) => User.fromDocument(doc)).toList();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 3,
            shadowColor: Colors.grey,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.blueAccent,
            toolbarHeight: 65,
            title: const Text(
              'O\'quvchilar',
              style: TextStyle(
                  color: Colors.white, fontSize: 35.0, fontFamily: 'SingleDay'),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return allusers(
                user: users[index],
              );
            },
          ),
        );
      },
    );
  }
}
