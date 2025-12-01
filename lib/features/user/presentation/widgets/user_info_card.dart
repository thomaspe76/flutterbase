import 'package:flutter/material.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_typography.dart';

/// Reusable card widget for displaying user information.
/// Demonstrates proper use of design system - no hardcoded values.
class UserInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const UserInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.iconTextGap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelSmall,
                  ),
                  const SizedBox(height: AppSpacing.xxxs),
                  Text(
                    value,
                    style: AppTypography.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
