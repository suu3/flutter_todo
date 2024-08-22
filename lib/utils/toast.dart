import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
    {required BuildContext context,
    required String text,
    Color bgColor = Colors.black}) {
  final fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: bgColor,
    ),
    child: Text(text, style: const TextStyle(color: Colors.white)),
  );

  fToast.showToast(
      child: toast,
      toastDuration: const Duration(milliseconds: 800),
      positionedToastBuilder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 20,
              child: child,
            ),
          ],
        );
      });
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
