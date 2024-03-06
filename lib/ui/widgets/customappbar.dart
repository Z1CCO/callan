import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isTimeLine;
  final String text;
  const CustomAppBar({
    super.key,
    required this.isTimeLine,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        isTimeLine ? text : text,
        style: TextStyle(
          color: isTimeLine ? Colors.white : Colors.white,
          fontSize: isTimeLine ? 40 : 25,
          fontFamily: isTimeLine ? 'Lobster' : '',
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
