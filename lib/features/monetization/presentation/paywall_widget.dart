import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/monetization/subscription_service.dart';

class PaywallWidget extends ConsumerWidget {
  const PaywallWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Upgrade to Pro',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Unlock all features and remove ads.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              // Implement purchase flow
              // ref.read(subscriptionServiceProvider.notifier).purchasePackage(package);
            },
            child: const Text('Subscribe now'),
          ),
          TextButton(
            onPressed: () {
              ref.read(subscriptionServiceProvider.notifier).restorePurchases();
            },
            child: const Text('Restore Purchases'),
          ),
        ],
      ),
    );
  }
}
