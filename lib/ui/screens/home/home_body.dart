import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/home/callan_elevated.dart';
import 'package:flutter_firebase_fire/ui/screens/home/callan_location.dart';
import 'package:flutter_firebase_fire/ui/screens/home/insta_ele.dart';
import 'package:flutter_firebase_fire/ui/screens/home/telefon.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.user,
    required this.isAdmin,
  });

  final User user;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue],
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.elliptical(200.0, 25.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 35.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 35.0,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  CachedNetworkImageProvider(user.photoUrl),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hushko`rdik',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  ),
                                ),
                                Text(
                                  user.username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isAdmin == false
                          ? Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Callan Coin:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    user.score.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Text(
                                'O\'qituvchilar uchun',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                ElevatedCoin(isAdmin: isAdmin, user: user)
              ],
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Murajat uchun',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const TelefonCallan(),
          const CallanLocation(),
          const InastaTele(),
        ],
      ),
    );
  }
}
