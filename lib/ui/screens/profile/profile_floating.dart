import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/ui/widgets/posts_list/upload_image.dart';

class ProfileFloat extends StatelessWidget {
  const ProfileFloat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (currentUser!.admin == true) {
      return FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadImage(currentUser: currentUser),
          ),
        ),
        child: const Icon(
          Icons.photo_camera_rounded,
          color: Colors.white,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
