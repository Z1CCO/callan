import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/post.dart';
import 'package:flutter_firebase_fire/ui/widgets/cachednetworkimagewidget.dart';
import 'package:flutter_firebase_fire/ui/widgets/posts_list/post_list_widget.dart';
import 'package:flutter_firebase_fire/util/show_post.dart';

class ProfilePostsWidget extends StatelessWidget {
  final List<Post> posts;
  final bool isPostOrientationGrid;
  const ProfilePostsWidget({
    Key? key,
    required this.posts,
    required this.isPostOrientationGrid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(15.0),
        child: Image(
          image: AssetImage('assets/images/callan2.png'),
          height: 300.0,
          fit: BoxFit.scaleDown,
        ),
      );
    }

    return isPostOrientationGrid
        ? GridView.count(
            childAspectRatio: 1.0,
            mainAxisSpacing: 1.5,
            crossAxisSpacing: 1.5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: posts
                .map(
                  (post) => GridTile(
                    child: GestureDetector(
                      onTap: () => showPost(context, post.postId, post.ownerId),
                      child: CachedNetworkImageWidget(
                        url: post.mediaUrl,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        : Column(
            children: posts.map((post) => PostListWidget(post: post)).toList(),
          );
  }
}
