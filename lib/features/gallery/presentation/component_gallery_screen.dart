import 'package:flutter/material.dart';
import '../../../shared/widgets/expressive_shell.dart';
import '../../../shared/widgets/state/empty_state_widget.dart';
import '../../../shared/widgets/state/error_state_widget.dart';
import '../../../shared/widgets/state/loading_overlay.dart';

class ComponentGalleryScreen extends StatelessWidget {
  const ComponentGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpressivePageShell(
      title: 'Component Gallery',
      subtitle: 'Showcase of all reusable widgets',
      children: [
        _Section(
          title: 'Buttons',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton(onPressed: () {}, child: const Text('Filled')),
              FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
              OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
              TextButton(onPressed: () {}, child: const Text('Text')),
            ],
          ),
        ),
        _Section(
          title: 'State Widgets',
          child: Column(
            children: [
              const Card(
                child: SizedBox(
                  height: 200,
                  child: EmptyStateWidget(
                    title: 'No Data',
                    message: 'This is an empty state example.',
                    icon: Icons.inbox,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: SizedBox(
                  height: 200,
                  child: ErrorStateWidget(
                    title: 'Error Occurred',
                    message: 'Something went wrong.',
                    onRetry: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        _Section(
          title: 'Loading Overlay',
          child: SizedBox(
            height: 150,
            child: LoadingOverlay(
              isLoading: true,
              message: 'Loading...',
              child: Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                alignment: Alignment.center,
                child: const Text('Content behind overlay'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
