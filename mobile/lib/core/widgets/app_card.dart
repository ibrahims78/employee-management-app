import 'package:flutter/material.dart';
import 'package:staff_health_mobile/core/theme/theme_extensions.dart';
import 'package:staff_health_mobile/core/theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  const AppCard({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? context.colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        side: BorderSide(color: context.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: child,
      ),
    );
  }
}
