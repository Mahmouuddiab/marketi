import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class AppToast {
  static void success(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static void error(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.error, color: Colors.white),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}