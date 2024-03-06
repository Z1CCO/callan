import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/post.dart';
import 'package:flutter_firebase_fire/ui/screens/comment_screen.dart';

class PostFuture extends StatelessWidget {
  const PostFuture({
    super.key,
    required this.post,
    required this.likesCount,
    required this.onLikePressed,
    required this.isLiked,
  });
  final VoidCallback onLikePressed;
  final bool isLiked;
  final Post post;
  final int likesCount;

  void showComments(
    BuildContext context, {
    required String postId,
    required String ownerId,
    required String mediaUrl,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentScreen(
          postId: postId,
          ownerId: ownerId,
          mediaUrl: mediaUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
              ),
              child: GestureDetector(
                onTap: onLikePressed,
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => showComments(
                context,
                postId: post.postId,
                ownerId: post.ownerId,
                mediaUrl: post.mediaUrl,
              ),
              child: Icon(
                Icons.chat,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 10.0,
            bottom: 5.0,
          ),
          child: Text(
            '$likesCount likes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Text(
                post.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(child: Text(post.description)),
          ],
        )
      ],
    );
  }
}
