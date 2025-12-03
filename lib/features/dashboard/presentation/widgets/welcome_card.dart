import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterbase/l10n/app_localizations.dart';
import '../../../settings/logic/settings_provider.dart';
import '../../../../core/theme/semantic_colors.dart';

class WelcomeCard extends ConsumerStatefulWidget {
  const WelcomeCard({super.key});

  @override
  ConsumerState<WelcomeCard> createState() => _WelcomeCardState();
}

class _WelcomeCardState extends ConsumerState<WelcomeCard> {
  bool _isActionCompleted = false;

  void _performAction() {
    final settings = ref.read(settingsProvider);

    setState(() {
      _isActionCompleted = true;
    });

    if (settings.hapticsEnabled) {
      HapticFeedback.mediumImpact();
    }

    // Reset after delay for demo purposes
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isActionCompleted = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Hero(
      tag: 'welcome_card',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child:
                        _WelcomeDetailsScreen(isCompleted: _isActionCompleted),
                  );
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animation, curve: Curves.easeOut,),
                      ),
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            color: theme.colorScheme.primaryContainer,
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.welcomeBack,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.welcomeAppTitle,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              theme.colorScheme.surface.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.rocket_launch_outlined,
                          color: theme.colorScheme.onPrimaryContainer,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Chip(
                        label: Text(l10n.welcomeVersion),
                        backgroundColor:
                            theme.extension<SemanticColors>()?.info ??
                                theme.colorScheme.surface,
                        labelStyle: TextStyle(
                          color: theme.extension<SemanticColors>()?.onInfo ??
                              theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(l10n.welcomePro),
                        backgroundColor:
                            theme.extension<SemanticColors>()?.success ??
                                theme.colorScheme.surface,
                        labelStyle: TextStyle(
                          color: theme.extension<SemanticColors>()?.onSuccess ??
                              theme.colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              scale: animation, child: child,);
                        },
                        child: _isActionCompleted
                            ? Container(
                                key: const ValueKey('done'),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: theme
                                          .extension<SemanticColors>()
                                          ?.success ??
                                      Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(Icons.check,
                                    color: theme
                                            .extension<SemanticColors>()
                                            ?.onSuccess ??
                                        Colors.white,),
                              )
                            : FilledButton.icon(
                                key: const ValueKey('action'),
                                onPressed: _performAction,
                                icon: const Icon(Icons.sync),
                                label: Text(l10n.welcomeSyncNow),
                                style: FilledButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onPrimary,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        .animate(target: settings.animationsEnabled ? 1 : 0)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad);
  }
}

class _WelcomeDetailsScreen extends StatelessWidget {
  final bool isCompleted;

  const _WelcomeDetailsScreen({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.welcomeDetails)),
      body: Hero(
        tag: 'welcome_card',
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(32),
              height: 400,
              width: double.infinity,
              child: Column(
                children: [
                  const Icon(Icons.rocket_launch, size: 64),
                  const SizedBox(height: 24),
                  Text(
                    l10n.welcomeSystemStatus,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.welcomeDemoDescription,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  if (isCompleted)
                    Chip(
                      label: Text(l10n.welcomeSynced),
                      backgroundColor: Theme.of(context)
                          .extension<SemanticColors>()
                          ?.success,
                      labelStyle: TextStyle(
                        color: Theme.of(context)
                            .extension<SemanticColors>()
                            ?.onSuccess,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
