import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class PlantIconCircle extends StatelessWidget {
  const PlantIconCircle({super.key, required this.scheme});
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

class FeaturePillsRow extends StatelessWidget {
  const FeaturePillsRow({super.key, required this.isDark});
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

class AllowButton extends StatelessWidget {
  const AllowButton({super.key, required this.scheme});
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

class LaterButton extends StatelessWidget {
  const LaterButton({super.key, required this.subtextColor, required this.isDark});
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
