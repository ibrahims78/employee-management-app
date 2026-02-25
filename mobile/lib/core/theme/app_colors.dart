import 'package:flutter/material.dart';

class AppColors {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2196F3),
    onPrimary: Colors.white,
    secondary: Color(0xFF03DAC6),
    onSecondary: Colors.black,
    error: Color(0xFFB00020),
    onError: Colors.white,
    background: Color(0xFFF5F5F5),
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    outline: Color(0xFF79747E),
    primaryContainer: Color(0xFFE3F2FD),
    secondaryContainer: Color(0xFFE0F2F1),
    tertiaryContainer: Color(0xFFF3E5F5),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF90CAF9),
    onPrimary: Colors.black,
    secondary: Color(0xFF03DAC6),
    onSecondary: Colors.black,
    error: Color(0xFFCF6679),
    onError: Colors.black,
    background: Color(0xFF121212),
    onBackground: Colors.white,
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
    outline: Color(0xFF938F99),
    primaryContainer: Color(0xFF1976D2),
    secondaryContainer: Color(0xFF00796B),
    tertiaryContainer: Color(0xFF7B1FA2),
  );
}
