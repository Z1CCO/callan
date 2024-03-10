import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/map_open.dart';

class CallanLocation extends StatelessWidget {
  const CallanLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MapUtils.openMap(40.53436, 70.94689);
      },
      child: Container(
        width: 110,
        height: 110,
        margin: const EdgeInsets.only(
            left: 15.0, right: 15.0, bottom: 15.0, top: 6.0),
        decoration: BoxDecoration(
          color: Colors.amber.shade700,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3, 3),
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
        ),
        child: const Icon(
          Icons.location_pin,
          size: 65.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
