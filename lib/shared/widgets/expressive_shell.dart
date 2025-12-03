import 'package:flutter/material.dart';

class ExpressivePageShell extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final List<Widget> children;
  final bool centerTitle;

  const ExpressivePageShell({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    required this.children,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Column(
              crossAxisAlignment: centerTitle
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(title),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
            actions: actions,
            centerTitle: centerTitle,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            sliver: SliverList(delegate: SliverChildListDelegate(children)),
          ),
          // Bottom padding for scrolling behind navigation bar
          const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
    );
  }
}
