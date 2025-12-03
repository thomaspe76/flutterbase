import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/expressive_shell.dart';
import 'package:go_router/go_router.dart';
import '../logic/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return ExpressivePageShell(
      title: 'Settings',
      subtitle: 'Manage your preferences',
      children: [
        _buildSectionHeader(context, 'Appearance'),
        Card(
          child: Column(
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('System'),
                value: ThemeMode.system,
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                groupValue: settings.themeMode,
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                onChanged: (val) => notifier.setThemeMode(val!),
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Light'),
                value: ThemeMode.light,
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                groupValue: settings.themeMode,
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                onChanged: (val) => notifier.setThemeMode(val!),
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Dark'),
                value: ThemeMode.dark,
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                groupValue: settings.themeMode,
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                // ignore: deprecated_member_use
                onChanged: (val) => notifier.setThemeMode(val!),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(context, 'Notifications'),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Enable Notifications'),
                value: settings.notificationsEnabled,
                onChanged: notifier.toggleNotifications,
                secondary: const Icon(Icons.notifications_outlined),
              ),
              if (settings.notificationsEnabled)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lead Time: ${settings.notificationLeadTime.round()} min',
                      ),
                      Slider(
                        value: settings.notificationLeadTime,
                        min: 5,
                        max: 60,
                        divisions: 11,
                        label: '${settings.notificationLeadTime.round()} min',
                        onChanged: notifier.setNotificationLeadTime,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(context, 'Security & Backup'),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Cloud Backup'),
                subtitle: const Text('Sync data securely'),
                value: settings.cloudBackupEnabled,
                onChanged: notifier.toggleCloudBackup,
                secondary: const Icon(Icons.cloud_upload_outlined),
              ),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: settings.themeMode == ThemeMode.dark,
                onChanged: notifier.toggleTheme,
                secondary: const Icon(Icons.dark_mode),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Accent Color',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _ColorOption(
                          color: 0xFF3F51B5, // Indigo
                          selectedColor: settings.themeColor,
                          onTap: () => notifier.updateThemeColor(0xFF3F51B5),
                        ),
                        _ColorOption(
                          color: 0xFF2196F3, // Blue
                          selectedColor: settings.themeColor,
                          onTap: () => notifier.updateThemeColor(0xFF2196F3),
                        ),
                        _ColorOption(
                          color: 0xFF009688, // Teal
                          selectedColor: settings.themeColor,
                          onTap: () => notifier.updateThemeColor(0xFF009688),
                        ),
                        _ColorOption(
                          color: 0xFF4CAF50, // Green
                          selectedColor: settings.themeColor,
                          onTap: () => notifier.updateThemeColor(0xFF4CAF50),
                        ),
                        _ColorOption(
                          color: 0xFFFFC107, // Amber
                          selectedColor: settings.themeColor,
                          onTap: () => notifier.updateThemeColor(0xFFFFC107),
                        ),
                        _ColorOption(
                          color: 0xFFFF5722, // Deep Orange
                          selectedColor: settings.themeColor,
                          onTap: () => notifier.updateThemeColor(0xFFFF5722),
                        ),
                        _ColorOption(
                          color: 0xFFE91E63, // Pink
                          selectedColor: settings.themeColor,
                          onTap: () => notifier.updateThemeColor(0xFFE91E63),
                        ),
                        _ColorOption(
                          color: 0xFF9C27B0, // Purple
                          selectedColor: settings.themeColor,
                          onTap: () => notifier.updateThemeColor(0xFF9C27B0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SwitchListTile(
                title: const Text('Haptics'),
                value: settings.hapticsEnabled,
                onChanged: notifier.toggleHaptics,
                secondary: const Icon(Icons.vibration),
              ),
              SwitchListTile(
                title: const Text('Animations'),
                value: settings.animationsEnabled,
                onChanged: notifier.toggleAnimations,
                secondary: const Icon(Icons.animation),
              ),
              SwitchListTile(
                title: const Text('Biometrics'),
                subtitle: const Text('Unlock with FaceID/Fingerprint'),
                value: settings.biometricsEnabled,
                onChanged: notifier.toggleBiometrics,
                secondary: const Icon(Icons.fingerprint),
              ),
              SwitchListTile(
                title: const Text('Privacy Mode'),
                subtitle: const Text('Blur app in background'),
                value: settings.privacyModeEnabled,
                onChanged: notifier.togglePrivacyMode,
                secondary: const Icon(Icons.privacy_tip_outlined),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(context, 'Legal'),
        Card(
          child: Column(
            children: [
              ListTile(
                title: const Text('Imprint'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Licenses'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showLicensePage(context: context);
                },
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text('Component Gallery'),
          leading: const Icon(Icons.style),
          onTap: () => context.push('/gallery'),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            'Version 1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title,
      {bool isDestructive = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: isDestructive
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final int color;
  final int selectedColor;
  final VoidCallback onTap;

  const _ColorOption({
    required this.color,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = color == selectedColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(color),
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 2,
                )
              : null,
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                color: ThemeData.estimateBrightnessForColor(Color(color)) ==
                        Brightness.dark
                    ? Colors.white
                    : Colors.black,
              )
            : null,
      ),
    );
  }
}
