import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/util/profile_show.dart';

class UserResultWidget extends StatelessWidget {
  final User user;
  const UserResultWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(.7),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () => showProfile(context, user.id),
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            ),
            title: Text(
              user.displayName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              user.username,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const Divider(height: 2, color: Colors.white54),
        ],
      ),
    );
  }
}
