import 'package:flutter/material.dart';

void showToast(
    {required BuildContext context,
    required IconData icon,
    required String text,
    Color bgColor = Colors.black}) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: bgColor, // 전달된 배경색 사용
    duration: const Duration(seconds: 1), // 지속 시간 1초
    behavior: SnackBarBehavior.floating, // floating 사용
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessToast(
    {required BuildContext context,
    required String text,
    Color bgColor = Colors.black}) {
  showToast(
      context: context,
      icon: Icons.check_circle_outline_outlined,
      text: text,
      bgColor: const Color.fromARGB(255, 96, 183, 99));
}

void showErrorToast(
    {required BuildContext context,
    required String text,
    Color bgColor = Colors.black}) {
  showToast(
      context: context,
      icon: Icons.error_outline,
      text: text,
      bgColor: const Color.fromARGB(255, 255, 82, 29));
}
