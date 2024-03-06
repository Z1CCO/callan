import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/activity/activity_feed_screen.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/ui/screens/profile/widgets/edit_profile.dart';
import 'package:flutter_firebase_fire/ui/screens/profile/widgets/profile_list_widget.dart';
import '../../../domain/entity/post.dart';
import '../search/editprofile/edit_profile_screen.dart';
import 'widgets/profile_header_widget.dart';

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
  final currentUserId = currentUser?.id;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _future;
  bool isLoading = false;
  late bool isFollowing;
  bool isFollowLoading = false;
  bool isPostOrientationGrid = true;
  int _postCount = 0;
  int _followersCount = 0;
  int _followingCount = 0;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _future = userDB.doc(widget.profileId).get();
    getProfilepost();
    getFollowersAndFollowing();
    checkFollowing();
  }

  void checkFollowing() async {
    final followerDoc = await followersDB
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId)
        .get();
    isFollowing = followerDoc.exists;
    setState(() {});
  }

  void getFollowersAndFollowing() async {
    final followers = await followersDB
        .doc(widget.profileId)
        .collection('userFollowers')
        .get();

    final follwings = await followingDB
        .doc(widget.profileId)
        .collection('userFollowing')
        .get();

    _followersCount = followers.docs.length;
    _followingCount = follwings.docs.length;
    setState(() {});
  }

  buildProfileButton() {
    final isProfileOwner = currentUserId == widget.profileId;

    if (isProfileOwner) {
      return EditProfileButtonWidget(
        isFollowing: isFollowing,
        title: 'Profilni tahrirlash',
        onPressed: editProfile,
      );
    }
    return EditProfileButtonWidget(
      isFollowing: isFollowing,
      title: isFollowing ? 'unfollow' : 'follow',
      onPressed: handleFollowingToggle,
      isFollowLoading: isFollowLoading,
    );
  }

  buildNavigatorPop() {
    final isProfileOwner = currentUserId == widget.profileId;

    if (isProfileOwner) {
      return null;
    }
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget natificationUser() {
    final isProfileOwner = currentUserId == widget.profileId;
    if (isProfileOwner) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ActivityFeedScreen()),
          ),
          icon: const Icon(
            Icons.notifications_on_sharp,
            size: 30.0,
            color: Colors.white,
          ),
        ),
      );
    }
    return const Text('');
  }

  void handleFollowingToggle() async {
    setState(() => isFollowLoading = true);
    final followersDoc = followersDB
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId);
    final followingDoc = followingDB
        .doc(currentUserId)
        .collection('userFollowing')
        .doc(widget.profileId);
    final activityDoc = activityDB
        .doc(widget.profileId)
        .collection('feedItems')
        .doc(currentUserId);

    if (isFollowing) {
      final docs = [followersDoc, followingDoc, activityDoc];
      for (var doc in docs) {
        var data = await doc.get();
        if (data.exists) await data.reference.delete();
      }
    } else {
      followersDoc.set({
        'ownerId': widget.profileId,
        'username': currentUser!.username,
        'userId': currentUserId,
        'userAvatar': currentUser!.photoUrl,
        'timestamp': DateTime.now(),
      });
      followingDoc.set({
        'ownerId': widget.profileId,
        'username': currentUser!.username,
        'userId': currentUserId,
        'userAvatar': currentUser!.photoUrl,
        'timestamp': DateTime.now(),
      });
      activityDoc.set({
        'type': 'follow',
        'ownerId': widget.profileId,
        'username': currentUser!.username,
        'userId': currentUserId,
        'userAvatar': currentUser!.photoUrl,
        'postId': '',
        'mediaUrl': '',
        'timestamp': DateTime.now(),
        'commentData': '',
      });
    }
    isFollowing = !isFollowing;
    isFollowLoading = false;
    getFollowersAndFollowing();
  }

  getProfilepost() async {
    setState(() => isLoading = true);
    final snapshot = await postDB
        .doc(widget.profileId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .get();

    isLoading = false;
    _postCount = snapshot.docs.length;
    posts = snapshot.docs.map((e) => Post.fromDocument(e)).toList();
    setState(() {});
  }

  editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          currentUserId: currentUserId!,
        ),
      ),
    );
    if (result) {
      _future = userDB.doc(widget.profileId).get();
      setState(() {});
    }
  }

  void togglePostOrientation() {
    isPostOrientationGrid = !isPostOrientationGrid;
    setState(() {});
  }

  void nulllll() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: buildNavigatorPop(),
        backgroundColor: Colors.blue,
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [natificationUser()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeaderWidget(
                followersCount: _followersCount,
                followingCount: _followingCount,
                future: _future,
                buildButton: buildProfileButton,
                postCount: _postCount),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed:
                      isPostOrientationGrid ? nulllll : togglePostOrientation,
                  icon: Icon(
                    Icons.grid_on,
                    color: isPostOrientationGrid ? Colors.black : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed:
                      !isPostOrientationGrid ? nulllll : togglePostOrientation,
                  icon: Icon(
                    Icons.list,
                    color: !isPostOrientationGrid ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
            ProfilePostsWidget(
                posts: posts, isPostOrientationGrid: isPostOrientationGrid)
          ],
        ),
      ),
    );
  }
}
