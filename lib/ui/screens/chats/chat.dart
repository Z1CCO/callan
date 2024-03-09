import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/chat.dart';
import 'package:flutter_firebase_fire/ui/screens/chats/arab_tili.dart';
import 'package:flutter_firebase_fire/ui/screens/chats/dasturlash.dart';
import 'package:flutter_firebase_fire/ui/screens/chats/ingiliz_tili.dart';
import 'package:flutter_firebase_fire/ui/screens/chats/rus_tili.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  List chatList = [
    const Dasturlash(),
    const IngilizTili(),
    const RusTili(),
    const ArabTili(),
  ];

  List chatListName = [
    'Dasturlash',
    'Ingiliz tili',
    'Rus tili',
    'Arab tili',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              chatList.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: Offset(1, 3),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Center(
                    child: ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => chatList[index],
                        ),
                      ),
                      leading: const CircleAvatar(),
                      title: Text(chatListName[index]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final ChatsClass massage;
  const MessageWidget({super.key, required this.massage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: CachedNetworkImageProvider(massage.avatar),
      ),
      title: Text(massage.message),
      subtitle: Text(
        timeago.format(
          massage.timestamp.toDate(),
        ),
      ),
    );
  }
}
