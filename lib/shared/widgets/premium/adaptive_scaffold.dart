import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdaptiveScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<NavigationDestination> destinations;
  final List<NavigationRailDestination> railDestinations;

  const AdaptiveScaffold({
    super.key,
    required this.navigationShell,
    required this.destinations,
    required this.railDestinations,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile Layout
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              destinations: destinations,
            ),
          );
        } else {
          // Tablet/Desktop Layout
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: (index) {
                    navigationShell.goBranch(
                      index,
                      initialLocation: index == navigationShell.currentIndex,
                    );
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: railDestinations,
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: navigationShell),
              ],
            ),
          );
        }
      },
    );
  }
}
