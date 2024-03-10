import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  String title;
  String subtitle;
  Widget leading;

  HomeHeader({
    required this.title,
    required this.subtitle,
    required this.leading,
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3, 3),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: widget.leading,
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
