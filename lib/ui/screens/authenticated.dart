import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/chats/chat.dart';
import 'package:flutter_firebase_fire/ui/screens/home/homedart.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'profile/profile_screen.dart';

class Authenticated extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  Authenticated({super.key, required this.currentIndex, required this.onTap});
  final _screens = [
    Home(profileId: currentUser!.id),
    ChatScreen(),
    ProfileScreen(
      profileId: currentUser!.id,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens.elementAt(currentIndex),
      bottomNavigationBar: cupertinoNavBar(
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}

// ignore: camel_case_types
class cupertinoNavBar extends StatelessWidget {
  const cupertinoNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GNav(
      tabBackgroundGradient: const LinearGradient(
        colors: [Colors.grey, Colors.black],
      ),
      color: Colors.black,
      curve: Curves.bounceIn,
      backgroundColor: Colors.transparent,
      iconSize: 24.0,
      selectedIndex: currentIndex,
      onTabChange: onTap,
      activeColor: Colors.white,
      tabBorder: Border.all(color: Colors.grey, width: 1),
      tabMargin: const EdgeInsets.all(18),
      padding: const EdgeInsets.all(15),
      gap: 35,
      tabs: const [
        GButton(
          icon: Icons.home_filled,
          text: 'Home',
        ),
        GButton(
          icon: Icons.chat,
          text: 'Chat',
        ),
        GButton(
          icon: Icons.account_circle_outlined,
          text: 'Profile',
        ),
      ],
    );
  }
}
