import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';

// ignore: camel_case_types
class allusers extends StatefulWidget {
  final User user;
  const allusers({
    super.key,
    required this.user,
  });

  @override
  State<allusers> createState() => _allusersState();
}

// ignore: camel_case_types
class _allusersState extends State<allusers> {
  final isAdmin = currentUser!.admin;
  void scorethirty() async {
    var currentScore = widget.user.score;
    int newScore = currentScore += 30;
    userDB.doc(widget.user.id).update({'score': newScore});
    setState(() {});
  }

  void score() async {
    var currentScore = widget.user.score;
    int newScore = currentScore += 40;
    userDB.doc(widget.user.id).update({'score': newScore});
    setState(() {});
  }

  void ball() async {
    var currentScore = widget.user.score;
    int newScore = currentScore += 50;
    userDB.doc(widget.user.id).update({'score': newScore});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          if (currentUser!.group == widget.user.group) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        }
        if (currentUser!.group == widget.user.group) {
          return Container(
            decoration: BoxDecoration(
              border: const Border(
                bottom: BorderSide(color: Colors.white, width: 2),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade400,
                  Colors.blue.shade200,
                  Colors.blue.shade100,
                ],
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                backgroundImage:
                    CachedNetworkImageProvider(widget.user.photoUrl),
              ),
              title: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: const TextStyle(fontSize: 21.0, color: Colors.black),
                  children: [
                    TextSpan(
                      text: widget.user.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    widget.user.score.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text(
                    'coin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              trailing: PopupMenuButton(
                icon: const Icon(
                  Icons.add,
                  size: 30.0,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: scorethirty,
                    child: const Text('30 ball qoshish'),
                  ),
                  PopupMenuItem(
                    onTap: score,
                    child: const Text('40 ball qoshish'),
                  ),
                  PopupMenuItem(
                    onTap: ball,
                    child: const Text('50 ball qoshish'),
                  ),
                  const PopupMenuItem(
                    child: Text('qaytish'),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
