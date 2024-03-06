import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/callan/callan.dart';
import 'package:flutter_firebase_fire/ui/screens/home/homedart.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/ui/widgets/posts_list/2me.dart';
import 'profile/profile_screen.dart';
import 'search/search.dart';

class Authenticated extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  Authenticated({super.key, required this.currentIndex, required this.onTap});
  final _screens = [
    Home(profileId: currentUser!.id),
    UploadImage(
      currentUser: currentUser,
    ),
    Callan(profileId: currentUser!.id),
    const Search(),
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
    return CupertinoTabBar(
      height: 80,
      backgroundColor: Colors.blue.shade700,
      iconSize: 35.0,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
            activeIcon: CircularCont(
              icon: Icon(
                Icons.local_fire_department_sharp,
                color: Colors.black,
              ),
            ),
            icon: Icon(
              Icons.local_fire_department_outlined,
              color: Colors.white,
            ),
            label: ''),
        BottomNavigationBarItem(
            activeIcon: CircularCont(
              icon: Icon(
                Icons.photo_camera_rounded,
                color: Colors.black,
              ),
            ),
            icon: Icon(
              Icons.photo_camera_outlined,
              color: Colors.white,
            ),
            label: ''),
        BottomNavigationBarItem(
            activeIcon: CircularCont(
              icon: Image(
                width: 50,
                height: 50,
                color: Colors.black,
                image: AssetImage('assets/images/callan2.png'),
              ),
            ),
            icon: Image(
              width: 40,
              height: 40,
              color: Colors.white,
              image: AssetImage('assets/images/callan2.png'),
            ),
            label: ''),
        BottomNavigationBarItem(
            activeIcon: CircularCont(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: ''),
        BottomNavigationBarItem(
            activeIcon: CircularCont(
              icon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
            ),
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
            label: ''),
      ],
    );
  }
}

class CircularCont extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  const CircularCont({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
