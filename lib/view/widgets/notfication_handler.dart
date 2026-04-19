import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

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
          filter: ImageFilter.blur(sigmaX: isDark ? 24 : 0, sigmaY: isDark ? 24 : 0),
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
                _PlantIconCircle(scheme: scheme),
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
                  style: TextStyle(fontSize: 14, color: subtextColor, height: 1.5),
                ),
                const SizedBox(height: 16),
                _FeaturePillsRow(isDark: isDark),
                const SizedBox(height: 28),
                _AllowButton(scheme: scheme),
                const SizedBox(height: 10),
                _LaterButton(subtextColor: subtextColor, isDark: isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlantIconCircle extends StatelessWidget {
  const _PlantIconCircle({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            scheme.primary.withValues(alpha: 0.15),
            scheme.primary.withValues(alpha: 0.04),
          ],
        ),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.25), width: 1.5),
      ),
      padding: const EdgeInsets.all(18),
      child: Image.asset('assets/icons/plant_icon.png', fit: BoxFit.contain),
    );
  }
}

class _FeaturePillsRow extends StatelessWidget {
  const _FeaturePillsRow({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _Pill(icon: Icons.water_drop_outlined, label: 'Water', color: Colors.blue, isDark: isDark),
        const SizedBox(width: 8),
        _Pill(icon: Icons.grass_outlined, label: 'Feed', color: Colors.green, isDark: isDark),
        const SizedBox(width: 8),
        _Pill(icon: Icons.wb_sunny_outlined, label: 'Light', color: Colors.orange, isDark: isDark),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label, required this.color, required this.isDark});
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _AllowButton extends StatelessWidget {
  const _AllowButton({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: <Color>[scheme.primary, Color.lerp(scheme.primary, Colors.teal, 0.5)!],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(color: scheme.primary.withValues(alpha: 0.38), blurRadius: 16, offset: const Offset(0, 6)),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            AwesomeNotifications().requestPermissionToSendNotifications();
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.notifications_active_outlined, size: 20),
              SizedBox(width: 8),
              Text('Allow Notifications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LaterButton extends StatelessWidget {
  const _LaterButton({required this.subtextColor, required this.isDark});
  final Color subtextColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: subtextColor.withValues(alpha: 0.25)),
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'Maybe Later',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: subtextColor),
        ),
      ),
    );
  }
}
