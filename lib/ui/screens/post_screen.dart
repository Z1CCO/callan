import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/post.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/ui/widgets/posts_list/post_list_widget.dart';

class PostScreen extends StatefulWidget {
  final String postId;
  final String userId;
  const PostScreen({
    super.key,
    required this.userId,
    required this.postId,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String posrDescription = '';
  bool isLoading = false;
  late Post post;

  void getPost() async {
    setState(() => isLoading = true);
    var data = await postDB
        .doc(widget.userId)
        .collection('userPosts')
        .doc(widget.postId)
        .get();
    post = Post.fromDocument(data);
    posrDescription = post.description;
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60.0,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          size: 25.0,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          posrDescription,
          style: const TextStyle(color: Colors.white, fontSize: 25.0),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: PostListWidget(post: post),
            ),
    );
  }
}
