import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonFuntion{

  static Future<void> launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  static  Future<void> sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': "Inquiry about services",
        'body': "Hello,\n\nI would like to know more about your services.",
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  static void urlCall(String txt) async {
    final Uri googleMapsUrl = Uri.parse(txt);
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  static void sendtoApplication(String txt)async{
    final String instagramUrl = 'https://www.instagram.com/virat.kohli';
    final String instagramAppUrl = txt;
    if (await canLaunchUrl(Uri.parse(instagramAppUrl))) {
      await launchUrl(Uri.parse(instagramAppUrl));
    } else {
      if (await canLaunchUrl(Uri.parse(instagramUrl))) {
        await launchUrl(Uri.parse(instagramUrl), mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch Instagram account';
      }
    }
  }

}