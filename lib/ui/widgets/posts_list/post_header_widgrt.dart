import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/post.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/util/profile_show.dart';

import '../../screens/homescreen.dart';

class PostHeaderWidget extends StatelessWidget {
  const PostHeaderWidget({
    super.key,
    required this.location,
    required this.ownerId,
    required this.postId,
  });
  final Post postId;
  final String location;
  final String ownerId;

  handlePostDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: Colors.white,
        title: const Text('Rasmni o\'chirish'),
        children: [
          SimpleDialogOption(
            child: const Text(
              'O\'chirish',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
              deletePost();
            },
          ),
          SimpleDialogOption(
            child: const Text('Qaytish'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void deletePost() async {
    postDB
        .doc(ownerId)
        .collection('userPosts')
        .doc(postId.postId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    storageRef.child("post_$postId.jpg").delete();

    final snapshot = await activityDB
        .doc(ownerId)
        .collection('feedItems')
        .where('postId', isEqualTo: postId)
        .get();

    for (var doc in snapshot.docs) {
      if (doc.exists) doc.reference.delete();
    }

    final commentsSnapshot =
        await commentDB.doc(postId.postId).collection('comments').get();

    for (var doc in commentsSnapshot.docs) {
      if (doc.exists) doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userDB.doc(ownerId).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        User user = User.fromDocument(snapshot.data);
        final bool isPostOwner = ownerId == currentUser!.id;
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(user.photoUrl),
          ),
          title: GestureDetector(
            onTap: () => showProfile(context, user.id),
            child: Text(
              user.username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          subtitle: Text(location),
          trailing: isPostOwner
              ? IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => handlePostDelete(context),
                )
              : null,
        );
      },
    );
  }
}
