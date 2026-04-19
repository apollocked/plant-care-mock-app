import 'dart:ui';
import 'package:flutter/material.dart';
import 'permission_dialog_components.dart';

class NotificationPermissionHandler {
  static void showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (_) => const _PermissionDialog(),
    );
  }
}

class _PermissionDialog extends StatelessWidget {
  const _PermissionDialog();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bg = isDark ? const Color(0xFF132218) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A2E25);
    final Color subtextColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : const Color(0xFF4A6355);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: isDark ? 24 : 0,
            sigmaY: isDark ? 24 : 0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : scheme.primary.withValues(alpha: 0.12),
                width: 1.2,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.1),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                PlantIconCircle(scheme: scheme),
                const SizedBox(height: 24),
                Text(
                  'Stay on top of\nyour plant care! 🌿',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Enable notifications so we can remind you when your plants need watering or fertilizing.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: subtextColor,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                FeaturePillsRow(isDark: isDark),
                const SizedBox(height: 28),
                AllowButton(scheme: scheme),
                const SizedBox(height: 10),
                LaterButton(subtextColor: subtextColor, isDark: isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
