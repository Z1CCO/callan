import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/chat.dart';
import 'package:flutter_firebase_fire/ui/screens/chats/chat.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';

class Dasturlash extends StatefulWidget {
  const Dasturlash({super.key});

  @override
  State<Dasturlash> createState() => _DasturlashState();
}

class _DasturlashState extends State<Dasturlash> {
  final _commentController = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _messagetrim;
  @override
  void initState() {
    super.initState();
    _messagetrim = chatDB
        .doc('dasturlash')
        .collection('dasturlash')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  void addComment() async {
    final textData = _commentController.text.trim();
    if (textData == '') {
      const ScaffoldMessenger(
        child: SnackBar(
          content: Text('Biror Izoh yozing'),
        ),
      );
    } else {
      await chatDB.doc('dasturlash').collection('dasturlash').add({
        'userId': currentUser!.id,
        'username': currentUser!.username,
        'avatar': currentUser!.photoUrl,
        'message': textData,
        'timestamp': DateTime.now(),
      });
    }

    _commentController.clear();
    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dasturlash',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _messagetrim,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List message = snapshot.data.docs
                    .map((doc) => ChatsClass.fromDocument(doc))
                    .toList();
                if (message.isEmpty) {
                  return const Center(
                    child: Text(
                      'Yozishmalar Yo\'q',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: message.length,
                  itemBuilder: (context, index) => MessageWidget(
                    massage: message[index],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Platform.isIOS ? 20.0 : 0.0),
            child: ListTile(
              title: TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Izoh yozish',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  isDense: true,
                ),
              ),
              trailing: IconButton(
                onPressed: addComment,
                splashRadius: 25.0,
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
