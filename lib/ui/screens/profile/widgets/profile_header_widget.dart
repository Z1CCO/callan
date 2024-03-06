import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';

import 'profile_column_count.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final Future future;
  final Function buildButton;
  final int postCount;
  final int followersCount;
  final int followingCount;

  const ProfileHeaderWidget({
    super.key,
    required this.future,
    required this.buildButton,
    required this.postCount,
    required this.followersCount,
    required this.followingCount,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        User _user = User.fromDocument(snapshot.data);
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: 270.0,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            Container(
              width: double.infinity,
              height: 170.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade600,
                      Colors.blue.shade500,
                    ]),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(38.0),
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              child: Stack(
                children: [
                  Container(
                    width: 115.0,
                    height: 110.0,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(70.0),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.0,
                    child: Container(
                      width: 110.0,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15.0,
                    right: 10.0,
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          CachedNetworkImageProvider(_user.photoUrl),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: SizedBox(
                  width: 220.0,
                  height: 110.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfileCountColumnWidget(
                            title: 'Rasmlar',
                            count: postCount,
                          ),
                          ProfileCountColumnWidget(
                            title: 'Obunachilar',
                            count: followersCount,
                          ),
                          ProfileCountColumnWidget(
                            title: 'Obunalar',
                            count: followingCount,
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(6.0),
                            padding: const EdgeInsets.all(3.0),
                            width: 220.0,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: buildButton(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _user.username,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: 420.0,
                height: 100.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          _user.displayName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                      ),
                      const Text(
                        'Men haqimda',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      if (_user.boi.isNotEmpty) Text(_user.boi)
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
