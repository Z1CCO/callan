import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/activity/is_admin.dart';

class ElevatedCoin extends StatelessWidget {
  const ElevatedCoin({
    super.key,
    required this.isAdmin,
    required this.user,
  });

  final bool isAdmin;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 50.0,
      right: 50.0,
      bottom: 20.0,
      child: SizedBox(
        width: 280.0,
        height: 45.0,
        child: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color.fromARGB(255, 83, 207, 89),
            ),
          ),
          onPressed: () {
            isAdmin == true
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IsAdmin(),
                    ),
                  )
                : const Text('');
          },
          child: isAdmin == false
              ? Row(
                  children: [
                    const Text(
                      'Tolov holati:',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    const Spacer(),
                    Text(
                      user.tolov,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ],
                )
              : const Text(
                  'O\'quvchilrani baholash',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
        ),
      ),
    );
  }
}
