import 'package:flutter/material.dart';

showMySnackBar({
  required String message,
  BuildContext? context,
  Color? color,
}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: color ?? Colors.green,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
  ));
}
