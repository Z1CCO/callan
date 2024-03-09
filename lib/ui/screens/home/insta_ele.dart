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
                                  image: AssetImage(''),
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
        margin: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 8.0),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade200,
              Colors.blue.shade200,
              Colors.yellow.shade800,
              Colors.yellow.shade800,
            ],
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/transparent.png'),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/tele.webp'),
                  ),
                ),
              ),
              const Text(
                '@Callan_education',
                style: TextStyle(fontSize: 22.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
