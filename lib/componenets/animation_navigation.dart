import 'package:flutter/material.dart';

class AnimationNavigation{
  static void navigateWithAnimation(BuildContext context,Widget classs) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 600), // Animation duration
        pageBuilder: (context, animation, secondaryAnimation) => classs,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Fade transition effect
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}