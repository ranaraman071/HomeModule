import 'package:flutter/material.dart';
import 'package:score_bar_project/presentation/widgets/common_text.dart';

void showCustomSnackBar(BuildContext context, String message, {Color color = Colors.green}) {
  final snackBar = SnackBar(
    content: CommonText(text: message,color: Colors.white), // Text color
    backgroundColor: color, // Custom background color
    behavior: SnackBarBehavior.floating, // Floating style
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    duration: const Duration(seconds: 3), // Duration of visibility
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}