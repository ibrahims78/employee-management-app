import 'package:flutter/material.dart';

class AppTextTheme {
  static const textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black54,
    ),
  );

  static final darkTextTheme = textTheme.copyWith(
    headlineLarge: textTheme.headlineLarge?.copyWith(color: Colors.white),
    titleMedium: textTheme.titleMedium?.copyWith(color: Colors.white70),
    bodyMedium: textTheme.bodyMedium?.copyWith(color: Colors.white60),
  );
}
