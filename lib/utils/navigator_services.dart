import 'package:flutter/material.dart';

class NavigatorService {
  // Singleton pattern to ensure only one instance of NavigatorService is created.
  static final NavigatorService _instance = NavigatorService._internal();

  factory NavigatorService() => _instance;

  NavigatorService._internal();

  // Global key for accessing the navigator.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Method for pushing to a new screen.
  Future<T?> push<T>(Widget page) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Method for pushing and replacing the current screen.
  Future<T?> pushReplacement<T>(Widget page) {
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Method for pushing and removing all previous routes.
  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
          (Route<dynamic> route) => false,
    );
  }

  // Method for popping the current screen.
  void pop<T>([T? result]) {
    return navigatorKey.currentState!.pop(result);
  }
}
