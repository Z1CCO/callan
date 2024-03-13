import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/activity/is_admin.dart';
import 'package:flutter_firebase_fire/ui/screens/callan/callan.dart';
import 'package:flutter_firebase_fire/ui/screens/home/callan_location.dart';
import 'package:flutter_firebase_fire/ui/screens/home/carousel_item.dart';
import 'package:flutter_firebase_fire/ui/screens/home/chat_callan.dart';
import 'package:flutter_firebase_fire/ui/screens/home/home_header.dart';
import 'package:flutter_firebase_fire/ui/screens/home/insta_ele.dart';
import 'package:flutter_firebase_fire/ui/screens/home/telefon.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';

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
                        widget.user.username,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const Spacer(),
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
                                builder: (context) => const ChatCallan()),
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
                items: const [
                  CarouselItemTwo(),
                  CarouselItem(),
                  CarouselItem(),
                ],
                options: CarouselOptions(
                    reverse: true,
                    enlargeCenterPage: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlay: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000),
                    aspectRatio: 13 / 8),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const TelefonCallan(),
                  const SizedBox(
                    width: 20,
                  ),
                  const CallanLocation(),
                  const SizedBox(
                    width: 20,
                  ),
                  const InastaTele(),
                  const SizedBox(
                    width: 20,
                  ),
                  if (currentUser!.teacher == true) const Baholash(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Baholash extends StatelessWidget {
  const Baholash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const IsAdmin(),
        ),
      ),
      child: Container(
        width: 70,
        height: 70,
        margin: const EdgeInsets.only(
            left: 15.0, right: 15.0, bottom: 15.0, top: 6.0),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3, 3),
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
        ),
        child: const Icon(
          Icons.filter_drama_rounded,
          size: 55.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
