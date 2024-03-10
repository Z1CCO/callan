import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/chats/chat.dart';
import 'package:flutter_firebase_fire/ui/screens/home/homedart.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: cupertinoNavBar(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
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
    return CupertinoTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.transparent,
      activeColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          activeIcon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            width: 80,
            height: 50,
            child: Image.asset(
              'assets/images/home.png',
              color: Colors.white,
            ),
          ),
          icon: SizedBox(
            width: 33,
            height: 33,
            child: Image.asset(
              'assets/images/home.png',
              color: Colors.black,
            ),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            width: 80,
            height: 50,
            child: Image.asset(
              'assets/images/chatt.png',
              color: Colors.white,
            ),
          ),
          icon: SizedBox(
            width: 33,
            height: 33,
            child: Image.asset(
              'assets/images/chatt.png',
              color: Colors.black,
            ),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            width: 80,
            height: 50,
            child: Image.asset(
              'assets/images/callan2.png',
              color: Colors.white,
            ),
          ),
          icon: SizedBox(
            width: 33,
            height: 33,
            child: Image.asset(
              'assets/images/callan2.png',
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
