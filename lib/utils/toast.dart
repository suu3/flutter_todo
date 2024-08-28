import 'package:flutter/material.dart';

void showToast(
    {required BuildContext context,
    required String text,
    Color bgColor = Colors.black}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: bgColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessToast(
    {required BuildContext context,
    required String text,
    Color bgColor = Colors.black}) {
  showToast(
      context: context,
      text: text,
      bgColor: const Color.fromARGB(255, 96, 183, 99));
}

void showErrorToast(
    {required BuildContext context,
    required String text,
    Color bgColor = Colors.black}) {
  showToast(
      context: context,
      text: text,
      bgColor: const Color.fromARGB(255, 255, 82, 29));
}
