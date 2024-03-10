import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/callan/callan.dart';
import 'package:flutter_firebase_fire/ui/screens/home/callan_location.dart';
import 'package:flutter_firebase_fire/ui/screens/home/carousel_item.dart';
import 'package:flutter_firebase_fire/ui/screens/home/chat_callan.dart';
import 'package:flutter_firebase_fire/ui/screens/home/home_header.dart';
import 'package:flutter_firebase_fire/ui/screens/home/insta_ele.dart';
import 'package:flutter_firebase_fire/ui/screens/home/telefon.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/ui/screens/search/editprofile/edit_profile_screen.dart';
import 'package:flutter_firebase_fire/ui/widgets/posts_list/2me.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
    required this.user,
    required this.isAdmin,
  });

  final User user;
  final bool isAdmin;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8.0, right: 12.0),
                        child: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(currentUser!.photoUrl),
                          radius: 25.0,
                        ),
                      ),
                      Text(
                        currentUser!.username,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                  currentUserId: currentUser!.id)),
                        ),
                        icon: const Icon(Icons.settings),
                      ),
                      if (currentUser!.admin == true)
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadImage(
                                currentUser: currentUser,
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.photo_camera,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: HomeHeader(
                          title: 'Cooming ',
                          subtitle: 'Soon',
                          leading: const CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: HomeHeader(
                          title: currentUser!.score.toString(),
                          subtitle: 'Point',
                          leading: const CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Callan(profileId: currentUser!.id),
                            ),
                          ),
                          child: HomeHeader(
                            title: 'Top',
                            subtitle: 'Students',
                            leading: const CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.leaderboard_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatCallan()),
                          ),
                          child: HomeHeader(
                            title: 'News',
                            subtitle: 'Callan',
                            leading: CircleAvatar(
                              backgroundColor: Colors.amber.shade900,
                              child: const Icon(
                                Icons.flash_on_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CarouselSlider(
                items: [
                  CarouselItem(),
                  CarouselItem(),
                  CarouselItem(),
                ],
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 7.5,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                ),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 10, bottom: 10),
                  child: Text(
                    'Murajat uchun',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TelefonCallan(),
                  CallanLocation(),
                  InastaTele(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
