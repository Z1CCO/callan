import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/map_open.dart';

class CallanLocation extends StatelessWidget {
  const CallanLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 15.0, right: 15.0, bottom: 15.0, top: 6.0),
      width: double.infinity,
      height: 150.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade500,
            Colors.blue.shade300,
            Colors.blue.shade100
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GestureDetector(
              onTap: () {
                MapUtils.openMap(40.53436, 70.94689);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                width: 120.0,
                height: 120.0,
                child: const Image(
                  color: Colors.black,
                  image: AssetImage('assets/images/callan2.png'),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Qo`qon shahar,'),
                        Text('Hamza 12-uy'),
                      ],
                    ),
                  ],
                ),
                Text(' 🇬🇧𝐈𝐧𝐠𝐥𝐢𝐳 𝐭𝐢𝐥𝐢'),
                Text(' 🇷🇺𝐑𝐮𝐬 𝐭𝐢𝐥𝐢'),
                Text(' 🇸🇦𝐀𝐫𝐚𝐛 𝐭𝐢𝐥𝐢 / 𝐗𝐚𝐭𝐭𝐨𝐭𝐥𝐢𝐤'),
                Text(' 💻 𝐈𝐓 𝐤𝐮𝐫𝐬𝐥𝐚𝐫𝐢'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
