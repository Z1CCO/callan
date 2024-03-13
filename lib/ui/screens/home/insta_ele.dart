import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/map_open.dart';

class InastaTele extends StatelessWidget {
  const InastaTele({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 120,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 241, 238),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/flut.png',
                    ),
                  ),
                  borderRadius: BorderRadius.circular(40)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      InstagrammUtils.openInstagramm();
                    },
                    child: const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/images/insta.png'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text('Instagram')
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      TelegrammUtils.openTelegramm();
                    },
                    child: const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: Image(
                              image: AssetImage('assets/images/tele.webp'),
                            ),
                          ),
                        ),
                        Text('Telegram')
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: 70,
        height: 70,
        margin: const EdgeInsets.only(
            left: 15.0, right: 15.0, bottom: 15.0, top: 6.0),
        decoration: BoxDecoration(
          color: Colors.indigoAccent.shade700,
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
          Icons.share,
          size: 55.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
