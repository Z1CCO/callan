import 'package:flutter/material.dart';

class EditProfileButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isFollowing;
  final bool isFollowLoading;
  const EditProfileButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isFollowing,
    this.isFollowLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230.0,
      height: 30.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isFollowing ? Colors.white : Colors.blue,
          primary: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side: isFollowing
              ? const BorderSide(color: Colors.grey)
              : BorderSide.none,
        ),
        onPressed: isFollowLoading ? null : onPressed,
        child: isFollowLoading
            ? const SizedBox(
                width: 20.0,
                height: 20.0,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 3.0),
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  color: isFollowing ? Colors.black : Colors.white,
                ),
              ),
      ),
    );
  }
}
