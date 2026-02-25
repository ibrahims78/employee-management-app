import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightColorScheme,
      textTheme: AppTextTheme.textTheme,
      scaffoldBackgroundColor: AppColors.lightColorScheme.background,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.darkColorScheme,
      textTheme: AppTextTheme.darkTextTheme,
      scaffoldBackgroundColor: AppColors.darkColorScheme.background,
    );
  }
}
