import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/profile/profile_screen.dart';

void showProfile(BuildContext context, String profileId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfileScreen(profileId: profileId),
    ),
  );
}
