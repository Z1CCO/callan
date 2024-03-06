import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelefonCallan extends StatelessWidget {
  const TelefonCallan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 15.0, right: 15.0, bottom: 15.0, top: 6.0),
      width: double.infinity,
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            '+998 97 129 11 11',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            height: 50.0,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  Color.fromARGB(255, 83, 207, 89),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Icon(
                Icons.call,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () async {
                final Uri url = Uri(
                  scheme: 'tel',
                  path: "+998 97 129 11 11",
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
