import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterbase/l10n/app_localizations.dart';
import '../../../settings/logic/settings_provider.dart';

class InteractiveSlider extends ConsumerStatefulWidget {
  const InteractiveSlider({super.key});

  @override
  ConsumerState<InteractiveSlider> createState() => _InteractiveSliderState();
}

class _InteractiveSliderState extends ConsumerState<InteractiveSlider> {
  double _currentValue = 0;

  void _updateValue(double value) {
    final settings = ref.read(settingsProvider);

    // Snap to 0, 25, 50, 75, 100
    double snappedValue = 0;
    if (value < 12.5) {
      snappedValue = 0;
    } else if (value < 37.5) {
      snappedValue = 25;
    } else if (value < 62.5) {
      snappedValue = 50;
    } else if (value < 87.5) {
      snappedValue = 75;
    } else {
      snappedValue = 100;
    }

    if (snappedValue != _currentValue) {
      if (settings.hapticsEnabled) {
        HapticFeedback.selectionClick();
      }
      setState(() {
        _currentValue = snappedValue;
      });
    }
  }

  Color _getColor(double value) {
    // Gradient from Blue to Purple
    return Color.lerp(Colors.blue, Colors.purple, value / 100) ?? Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.sliderTitle, style: theme.textTheme.titleMedium),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getColor(_currentValue).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${_currentValue.round()}%',
                    style: TextStyle(
                      color: _getColor(_currentValue),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48, // Increased tap target size for accessibility
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      double newValue =
                          (details.localPosition.dx / constraints.maxWidth) *
                              100;
                      newValue = newValue.clamp(0, 100);
                      _updateValue(newValue);
                    },
                    onTapUp: (details) {
                      double newValue =
                          (details.localPosition.dx / constraints.maxWidth) *
                              100;
                      newValue = newValue.clamp(0, 100);
                      _updateValue(newValue);
                    },
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        // Track
                        Container(
                          height: 12,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        // Fill
                        AnimatedContainer(
                          duration: settings.animationsEnabled
                              ? const Duration(milliseconds: 300)
                              : Duration.zero,
                          curve: Curves.easeOutBack,
                          height: 12,
                          width: constraints.maxWidth * (_currentValue / 100),
                          decoration: BoxDecoration(
                            color: _getColor(_currentValue),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        // Thumb
                        AnimatedAlign(
                          duration: settings.animationsEnabled
                              ? const Duration(milliseconds: 300)
                              : Duration.zero,
                          curve: Curves.easeOutBack,
                          alignment: Alignment((_currentValue / 50) - 1, 0),
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                color: _getColor(_currentValue),
                                width: 4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.sliderLow,
                    style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant)),
                Text(l10n.sliderMed,
                    style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant)),
                Text(l10n.sliderHigh,
                    style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
