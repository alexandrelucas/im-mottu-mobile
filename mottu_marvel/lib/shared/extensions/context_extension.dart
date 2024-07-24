import 'package:flutter/material.dart';

extension SnackMessage on BuildContext {
  void showSnackMessage(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
