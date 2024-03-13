import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void showPost(
  BuildContext context,
  String postId,
  String userId,
  String description,
  String photo,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => PostList(
              description: description,
              photo: photo,
            )),
  );
}

class PostList extends StatefulWidget {
  final String description;
  final String photo;
  const PostList({super.key, required this.description, required this.photo});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  bool showHeart = false;
  late bool isLiked;
  late int likesCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Callan Education'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            width: double.infinity,
            height: 500,
            child: CachedNetworkImage(
              imageUrl: widget.photo,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: Text(
              widget.description,
              style: const TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
