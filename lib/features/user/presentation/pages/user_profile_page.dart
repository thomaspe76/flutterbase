import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/user_providers.dart';
import '../widgets/user_avatar.dart';
import '../widgets/user_info_card.dart';

/// User profile page - demonstrates proper separation of concerns.
/// - No business logic (handled by use cases)
/// - No data fetching logic (handled by repository)
/// - Only UI and interaction with state management
/// - All strings from localization
/// - All design values from design system
class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  void initState() {
    super.initState();
    // Load user data when page initializes
    Future.microtask(
      () => ref.read(currentUserProvider.notifier).loadCurrentUser(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final userState = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: userState.when(
        initial: () => Center(
          child: Text(
            l10n.loading,
            style: AppTypography.bodyMedium,
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loaded: (user) => SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // User Avatar
              Center(
                child: UserAvatar(
                  avatarUrl: user.avatarUrl,
                  initials: user.initials,
                  radius: 60,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // User Name
              Text(
                user.name,
                style: AppTypography.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),

              // User Email
              Text(
                user.email,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sectionSpacing),

              // User Info Cards
              UserInfoCard(
                title: l10n.email,
                value: user.email,
                icon: Icons.email,
              ),
              const SizedBox(height: AppSpacing.listItemSpacing),

              // Edit Button
              const SizedBox(height: AppSpacing.sectionSpacing),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to edit profile
                },
                icon: const Icon(Icons.edit),
                label: Text(l10n.edit),
              ),

              // Sign Out Button
              const SizedBox(height: AppSpacing.xs),
              TextButton.icon(
                onPressed: () {
                  // Sign out
                },
                icon: const Icon(Icons.logout),
                label: Text(l10n.signOut),
              ),
            ],
          ),
        ),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                message,
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(currentUserProvider.notifier).loadCurrentUser();
                },
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
