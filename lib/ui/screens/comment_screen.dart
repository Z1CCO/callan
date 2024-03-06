import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/util/profile_show.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/comment.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String mediaUrl;
  const CommentScreen(
      {super.key,
      required this.postId,
      required this.ownerId,
      required this.mediaUrl});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final _commentController = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _commentStrim;
  @override
  void initState() {
    super.initState();
    _commentStrim = commentDB
        .doc(widget.postId)
        .collection('comments')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  void addComment() async {
    final currentUserId = currentUser!.id;
    final textData = _commentController.text.trim();
    if (textData == '') {
      const ScaffoldMessenger(
        child: SnackBar(
          content: Text('Biror Izoh yozing'),
        ),
      );
    } else {
      await commentDB.doc(widget.postId).collection('comments').add({
        'userId': currentUser!.id,
        'username': currentUser!.username,
        'avatar': currentUser!.photoUrl,
        'comment': textData,
        'timestamp': DateTime.now(),
      });
    }
    if (currentUserId != widget.ownerId) {
      activityDB
          .doc(widget.ownerId)
          .collection('feedItems')
          .doc(widget.postId)
          .set({
        'type': 'comment',
        'commentData': textData,
        'username': currentUser!.username,
        'userId': currentUserId,
        'userAvatar': currentUser!.photoUrl,
        'postId': widget.postId,
        'mediaUrl': widget.mediaUrl,
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
        iconTheme: const IconThemeData(color: Colors.white, size: 28.0),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Izohlar',
          style: TextStyle(fontSize: 25.0, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _commentStrim,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List comments = snapshot.data.docs
                    .map((doc) => Comments.fromDocument(doc))
                    .toList();
                if (comments.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Comment',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: comments.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 0.0,
                    color: Colors.black,
                  ),
                  itemBuilder: (context, index) => CommentWidget(
                    commentData: comments[index],
                  ),
                );
              },
            ),
          ),
          const Divider(
            color: Colors.black,
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

class CommentWidget extends StatelessWidget {
  final Comments commentData;
  const CommentWidget({super.key, required this.commentData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => showProfile(
        context,
        commentData.userId,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: CachedNetworkImageProvider(commentData.avatar),
      ),
      title: Text(commentData.comment),
      subtitle: Text(
        timeago.format(
          commentData.timestamp.toDate(),
        ),
      ),
    );
  }
}
