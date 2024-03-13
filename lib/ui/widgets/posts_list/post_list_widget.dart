import 'dart:async';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/post.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/ui/widgets/cachednetworkimagewidget.dart';
import 'package:flutter_firebase_fire/ui/widgets/posts_list/post_footer_widget.dart';
import 'package:flutter_firebase_fire/ui/widgets/posts_list/post_header_widgrt.dart';
import 'package:flutter_firebase_fire/ui/widgets/posts_list/upload_image.dart';

class PostListWidget extends StatefulWidget {
  final Post post;
  const PostListWidget({super.key, required this.post});

  @override
  State<PostListWidget> createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  final currentUserId = currentUser!.id;
  bool showHeart = false;
  late bool isLiked;
  late int likesCount;

  int getlikesCount() {
    if (widget.post.likes == null) return 0;
    int count = 0;
    widget.post.likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  void handleLikePost() {
    bool isLiked = widget.post.likes[currentUserId] ?? false;
    if (isLiked) {
      postDB.doc(postId).update({'likes.$currentUserId': false});
      activityFeedAction('delete');
      likesCount -= 1;
      isLiked = false;
      widget.post.likes[currentUserId] = false;
      setState(() {});
    } else {
      postDB.doc(postId).update({'likes.$currentUserId': true});
      showHeart = true;
      activityFeedAction('like');
      likesCount += 1;
      isLiked = true;
      widget.post.likes[currentUserId] = true;
      setState(() {});
      Timer(const Duration(milliseconds: 800), () {
        setState(() => showHeart = false);
      });
    }
  }

  void activityFeedAction(String type) {
    if (currentUserId == widget.post.ownerId) return;
    final doc = activityDB
        .doc(widget.post.ownerId)
        .collection('feedItems')
        .doc(widget.post.postId);
    if (type == 'delete') {
      doc.get().then(
        (data) {
          if (data.exists) data.reference.delete();
        },
      );
      return;
    }
    doc.set({
      'type': type,
      'username': currentUser!.username,
      'userId': currentUserId,
      'userAvatar': currentUser!.photoUrl,
      'postId': widget.post.postId,
      'mediaUrl': widget.post.mediaUrl,
      'timestamp': DateTime.now(),
      'commentData': '',
    });
  }

  @override
  void initState() {
    super.initState();
    likesCount = getlikesCount();
    isLiked = (widget.post.likes[currentUserId]) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostHeaderWidget(
          postId: widget.post,
          ownerId: widget.post.ownerId,
        ),
        GestureDetector(
          onDoubleTap: handleLikePost,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImageWidget(
                height: 450.0,
                url: widget.post.mediaUrl,
              ),
              if (showHeart)
                Animator(
                  duration: const Duration(milliseconds: 400),
                  tween: Tween(begin: 0.8, end: 1.4),
                  curve: Curves.easeInOut,
                  cycles: 0,
                  builder: (context, AnimatorState animatorState, _) =>
                      Transform.scale(
                    scale: animatorState.animation.value,
                    child: const Icon(
                      Icons.favorite,
                      size: 80.0,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
        PostFuture(
          post: widget.post,
          isLiked: isLiked,
          likesCount: likesCount,
          onLikePressed: handleLikePost,
        ),
      ],
    );
  }
}
