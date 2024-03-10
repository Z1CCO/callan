import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/home/home_body.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';

class HomeUser extends StatefulWidget {
  final Future future;
  const HomeUser({super.key, required this.future});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final isAdmin = currentUser!.admin;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        User user = User.fromDocument(snapshot.data);
        return Container(
          height: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: HomeBody(user: user, isAdmin: isAdmin),
          ),
        );
      },
    );
  }
}
