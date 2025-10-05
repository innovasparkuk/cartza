import 'package:flutter/material.dart';

class NotificationService {
  static final List<Map<String, String>> notifications = [];

  static void addNotification(BuildContext context, String title, String subtitle) {
    notifications.add({"title": title, "subtitle": subtitle});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      ),
    );
  }

  static void clearAll() {
    notifications.clear();
  }
}
