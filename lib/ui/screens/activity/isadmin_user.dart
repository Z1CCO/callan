import 'package:cached_network_image/cached_network_image.dart';
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
  int five = 5;
  final isAdmin = currentUser!.admin;
  void ball() async {
    var currentScore = widget.user.score;
    int newScore = currentScore += five;
    userDB.doc(widget.user.id).update({'score': newScore});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
          backgroundImage: CachedNetworkImageProvider(widget.user.photoUrl),
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
              onTap: ball,
              child: const Text('5 ball qoshish'),
            ),
            const PopupMenuItem(
              child: Text('qaytish'),
            )
          ],
        ),
      ),
    );
  }
}
