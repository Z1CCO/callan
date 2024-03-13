import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/callan/globaltab.dart';

class Callan extends StatefulWidget {
  final String profileId;

  const Callan({super.key, required this.profileId});

  @override
  State<Callan> createState() => _CallanState();
}

class _CallanState extends State<Callan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/bakkk.jpg'),
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: GlobalTab(),
      ),
    );
  }
}
