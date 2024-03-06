import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(
    double latitude,
    double longtude,
  ) async {
    String googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longtude';
    // ignore: deprecated_member_use
    if (await canLaunch(googleMapUrl)) {
      // ignore: deprecated_member_use
      await launch(googleMapUrl);
    }
  }
}

class InstagrammUtils {
  InstagrammUtils._();
  static Future<void> openInstagramm() async {
    String instaUrl = 'https://www.instagram.com/callan.education/';
// ignore: deprecated_member_use
    if (await canLaunch(instaUrl)) {
      // ignore: deprecated_member_use
      await launch(instaUrl);
    }
  }
}

class TelegrammUtils {
  TelegrammUtils._();
  static Future<void> openTelegramm() async {
    String telegramUrl = 'https://www.telegram.org/a/#-1001710652163';
// ignore: deprecated_member_use
    if (await canLaunch(telegramUrl)) {
      // ignore: deprecated_member_use
      await launch(telegramUrl);
    }
  }
}
