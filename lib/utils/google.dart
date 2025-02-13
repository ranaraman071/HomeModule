import 'package:url_launcher/url_launcher.dart';

Future<void> openGoogleMaps(String latitude,String long) async {

  // String googleMapsUrl = 'https://www.google.com/maps?q=$latitude,-$long';
  String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$long';
  print("google--$googleMapsUrl");

  try {
    final Uri googleUrl = Uri.parse(googleMapsUrl);
    final bool isAppAvailable = await canLaunchUrl(googleUrl);
    if (isAppAvailable) {await launchUrl(googleUrl);}
    else {await launchUrl(googleUrl);}
  } catch (e) {
    print('Error: $e');
  }
}