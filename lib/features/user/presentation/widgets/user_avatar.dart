import 'package:flutter/material.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_typography.dart';

/// Reusable user avatar widget.
/// Demonstrates single responsibility - only handles avatar display.
class UserAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String initials;
  final double radius;

  const UserAvatar({
    super.key,
    this.avatarUrl,
    required this.initials,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(avatarUrl!),
        backgroundColor: AppColors.primary,
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary,
      child: Text(
        initials,
        style: AppTypography.h3.copyWith(
          color: AppColors.textOnPrimary,
          fontSize: radius * 0.5,
        ),
      ),
    );
  }
}
