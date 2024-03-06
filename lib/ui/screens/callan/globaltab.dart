import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/util/profile_show.dart';

class GlobalTab extends StatefulWidget {
  const GlobalTab({
    super.key,
  });

  @override
  State<GlobalTab> createState() => _GlobalTabState();
}

class _GlobalTabState extends State<GlobalTab> {
  final currentRank = currentUser?.score;

  Future<List> getActivityuser() async {
    final snapshot = await userDB.orderBy('score').limit(10).get();

    return snapshot.docs;
  }

  List top10 = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getActivityuser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List users =
              snapshot.data.map((doc) => User.fromDocument(doc)).toList();
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) => GlobalTabItemWidget(
              rank: currentRank!.toString(),
              user: users[index],
              reating: top10[index],
            ),
          );
        },
      ),
    );
  }
}

class GlobalTabItemWidget extends StatefulWidget {
  final User user;
  final String rank;
  final String reating;

  const GlobalTabItemWidget(
      {super.key,
      required this.user,
      required this.rank,
      required this.reating});

  @override
  State<GlobalTabItemWidget> createState() => _GlobalTabItemWidgetState();
}

class _GlobalTabItemWidgetState extends State<GlobalTabItemWidget> {
  int top = 0;
  void orin(int index) {
    top = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade800,
            Colors.amber.shade500,
            Colors.amber.shade200
          ],
        ),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: CachedNetworkImageProvider(widget.user.photoUrl),
        ),
        title: GestureDetector(
          onTap: () => showProfile(context, widget.user.id),
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: const TextStyle(fontSize: 18.0, color: Colors.black),
              children: [
                TextSpan(
                  text: widget.user.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              widget.user.score.toString(),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              width: 5.0,
            ),
            const Text(
              'coin',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Text(
              widget.reating,
              style: const TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
