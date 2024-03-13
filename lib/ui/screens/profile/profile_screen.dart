import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/home/edit_profile.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/ui/screens/profile/profile_floating.dart';
import 'package:flutter_firebase_fire/util/show_post.dart';

class ProfileScreen extends StatefulWidget {
  final String profileId;

  const ProfileScreen({
    super.key,
    required this.profileId,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Future? _future;

  @override
  void initState() {
    _future = getActivityuser();
    super.initState();
  }

  Future getActivityuser() async {
    await FirebaseFirestore.instance
        .collection('posts')
        .orderBy(
          'postId',
        )
        .limit(1000)
        .get()
        .then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.docs.forEach(
            (element) {
              posts.add(element.reference.id);
            },
          ),
        );
  }

  List<String> posts = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              leading: const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Image(
                  image: AssetImage('assets/images/callan2.png'),
                ),
              ),
              title: const Text('Callan Education'),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: GridView.builder(
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemBuilder: (BuildContext context, int index) =>
                  Profile_Grid_Item(
                id: posts[index],
              ),
            ),
            floatingActionButton: const ProfileFloat(),
          );
        });
  }
}

// ignore: camel_case_types
class Profile_Grid_Item extends StatelessWidget {
  final String id;
  const Profile_Grid_Item({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postDB.doc(id).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                showPost(
                  context,
                  data['postId'],
                  data['ownerId'],
                  data['description'],
                  data['mediaUrl'],
                );
              },
              child: CachedNetworkImage(
                imageUrl: data['mediaUrl'],
                fit: BoxFit.cover,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
