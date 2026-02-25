import 'package:flutter/material.dart';
import 'package:staff_health_mobile/core/theme/theme_extensions.dart';
import 'package:staff_health_mobile/core/theme/app_spacing.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.sm)),
      ),
      child: isLoading
          ? CircularProgressIndicator(color: context.colorScheme.onPrimary)
          : Text(label, style: context.textTheme.titleMedium?.copyWith(color: context.colorScheme.onPrimary)),
    );
  }
}
