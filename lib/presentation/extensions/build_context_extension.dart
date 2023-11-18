import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  void shohSnackbar(String message) => ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
}
