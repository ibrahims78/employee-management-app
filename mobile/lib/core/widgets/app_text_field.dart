import 'package:flutter/material.dart';
import 'package:staff_health_mobile/core/theme/theme_extensions.dart';
import 'package:staff_health_mobile/core/theme/app_spacing.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: context.textTheme.bodyMedium,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.sm)),
        filled: true,
        fillColor: context.colorScheme.surface,
      ),
    );
  }
}
