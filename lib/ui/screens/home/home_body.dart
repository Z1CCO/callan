import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/callan/callan.dart';
import 'package:flutter_firebase_fire/ui/screens/home/callan_location.dart';
import 'package:flutter_firebase_fire/ui/screens/home/insta_ele.dart';
import 'package:flutter_firebase_fire/ui/screens/home/telefon.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/ui/widgets/posts_list/2me.dart';

class HomeBody extends StatefulWidget {
  HomeBody({
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CircleAvatar(
                    radius: 20.0,
                  ),
                ),
                title: Text(
                  currentUser!.username,
                ),
                actions: [
                  if (currentUser!.admin == true)
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadImage(
                            currentUser: currentUser,
                          ),
                        ),
                      ),
                      child: const Icon(Icons.photo_camera),
                    ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CircularContainer(
                      title: 'Cooming ',
                      subtitle: 'Soon',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CircularContainer(
                      title: currentUser!.score.toString(),
                      subtitle: 'Point',
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
                      child: CircularContainer(
                        title: 'Top',
                        subtitle: 'Students',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CircularContainer(
                      title: '',
                      subtitle: '',
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Murajat uchun',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const TelefonCallan(),
              const CallanLocation(),
              const InastaTele(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CircularContainer extends StatefulWidget {
  String title;
  String subtitle;

  CircularContainer({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  State<CircularContainer> createState() => _CircularContainerState();
}

class _CircularContainerState extends State<CircularContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: const CircleAvatar(),
        title: Text(
          widget.title,
        ),
        subtitle: Text(
          widget.subtitle,
        ),
      ),
    );
  }
}
