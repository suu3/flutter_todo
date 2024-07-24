import 'package:flutter/material.dart';

TextTheme createTextTheme(BuildContext context) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  return baseTextTheme.copyWith(
    bodyLarge:
        const TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w400),
    bodyMedium:
        const TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w400),
    bodySmall:
        const TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w400),
    labelLarge:
        const TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w500),
    labelMedium:
        const TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w500),
    labelSmall:
        const TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w500),
  );
}
