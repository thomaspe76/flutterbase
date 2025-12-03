import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterbase/features/dashboard/presentation/widgets/interactive_slider.dart';
import 'package:flutterbase/features/dashboard/presentation/widgets/welcome_card.dart';
import 'package:flutterbase/l10n/app_localizations.dart';
import '../../settings/logic/settings_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(l10n.dashboardTitle),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeCard(),
                  const SizedBox(height: 24),
                  Text(
                    l10n.dashboardUIShowcase,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                      .animate(target: settings.animationsEnabled ? 1 : 0)
                      .fadeIn(delay: 300.ms)
                      .slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 16),
                  const InteractiveSlider()
                      .animate(target: settings.animationsEnabled ? 1 : 0)
                      .fadeIn(delay: 400.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 24),
                  Text(
                    l10n.dashboardRecentActivity,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                      .animate(target: settings.animationsEnabled ? 1 : 0)
                      .fadeIn(delay: 500.ms)
                      .slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 16),
                  _buildActivityItem(
                    context,
                    l10n.activitySystemUpdate,
                    l10n.activitySystemUpdateDesc,
                    Icons.system_update,
                    Colors.blue,
                  ),
                  _buildActivityItem(
                    context,
                    l10n.activitySecurityCheck,
                    l10n.activitySecurityCheckDesc,
                    Icons.security,
                    Colors.green,
                  ),
                  _buildActivityItem(
                    context,
                    l10n.activityBackupCompleted,
                    l10n.activityBackupCompletedDesc,
                    Icons.cloud_done,
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    final settings = ProviderScope.containerOf(context).read(settingsProvider);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    )
        .animate(target: settings.animationsEnabled ? 1 : 0)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.2, end: 0);
  }
}
