import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelefonCallan extends StatelessWidget {
  const TelefonCallan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri(
          scheme: 'tel',
          path: "+998 97 129 11 11",
        );
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      },
      child: Container(
        width: 110,
        height: 110,
        margin: const EdgeInsets.only(
            left: 15.0, right: 15.0, bottom: 15.0, top: 6.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 36, 203, 41),
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
          Icons.call,
          size: 65.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
