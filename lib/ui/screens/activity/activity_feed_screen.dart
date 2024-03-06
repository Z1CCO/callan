import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/activity_feed.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/util/profile_show.dart';
import 'package:flutter_firebase_fire/util/show_post.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityFeedScreen extends StatefulWidget {
  const ActivityFeedScreen({super.key});

  @override
  State<ActivityFeedScreen> createState() => _ActivityFeedScreenState();
}

class _ActivityFeedScreenState extends State<ActivityFeedScreen> {
  Future<List> getActivityFeed() async {
    final snapshot = await activityDB
        .doc(currentUser!.id)
        .collection('feedItems')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .get();

    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue.shade600,
        centerTitle: true,
        toolbarHeight: 70.0,
        title: const Text(
          'Faoliyat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontFamily: 'SingleDay',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getActivityFeed(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List feeds = snapshot.data
              .map((doc) => ActivityFeed.fromDocument(doc))
              .toList();
          return ListView.builder(
            itemCount: feeds.length,
            itemBuilder: (context, index) => ActivityFeedScreenItemWidget(
              feed: feeds[index],
            ),
          );
        },
      ),
    );
  }
}

class ActivityFeedScreenItemWidget extends StatelessWidget {
  final ActivityFeed feed;
  const ActivityFeedScreenItemWidget({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    final mediaPreview = feed.type == 'like' || feed.type == 'comment'
        ? GestureDetector(
            onTap: () => showPost(context, feed.userId, feed.postId),
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(feed.mediaUrl),
                    ),
                  ),
                ),
              ),
            ),
          )
        : null;
    final activityItemText = feed.type == 'like'
        ? 'liked your post'
        : feed.type == 'follow'
            ? 'is following you'
            : ' repleid ${feed.commentData}';
    return Container(
      margin: const EdgeInsets.only(bottom: 2.0),
      color: Colors.grey.shade300,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: CachedNetworkImageProvider(feed.userAvatar),
        ),
        title: GestureDetector(
          onTap: () => showProfile(context, feed.userId),
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
              children: [
                TextSpan(
                  text: feed.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' $activityItemText'),
              ],
            ),
          ),
        ),
        subtitle: Text(
          timeago.format(
            feed.timestamp.toDate(),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: mediaPreview,
      ),
    );
  }
}
