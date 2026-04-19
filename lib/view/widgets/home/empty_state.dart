import 'package:flutter/material.dart';

class EmptyPlantState extends StatelessWidget {
  const EmptyPlantState({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: <Color>[
                    scheme.primary.withValues(alpha: 0.15),
                    scheme.primary.withValues(alpha: 0.03),
                  ],
                ),
                border: Border.all(
                  color: scheme.primary.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(28),
              child: Image.asset(
                'assets/icons/plant_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Plants Yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF14312C),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Add your first plant and start tracking its care schedule with daily reminders.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.5)
                    : Colors.black.withValues(alpha: 0.45),
              ),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: <Color>[
                    scheme.primary.withValues(alpha: 0.15),
                    scheme.primary.withValues(alpha: 0.05),
                  ],
                ),
                border: Border.all(color: scheme.primary.withValues(alpha: 0.3)),
              ),
              child: Text(
                '🌱 Tap "Add Plant" to get started',
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
