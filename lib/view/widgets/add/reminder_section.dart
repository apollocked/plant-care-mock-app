// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';
import 'form_helpers.dart';

class ReminderSection extends StatelessWidget {
  const ReminderSection({
    super.key,
    required this.remindersEnabled,
    required this.waterTime,
    required this.feedTime,
    required this.onToggleReminders,
    required this.onPickWaterTime,
    required this.onPickFeedTime,
    required this.onSurface,
  });

  final bool remindersEnabled;
  final TimeOfDay waterTime;
  final TimeOfDay feedTime;
  final ValueChanged<bool> onToggleReminders;
  final VoidCallback onPickWaterTime;
  final VoidCallback onPickFeedTime;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return GlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FormSectionHeader(
                icon: '🔔',
                label: 'Reminders',
                onSurface: onSurface,
              ),
              Switch.adaptive(
                value: remindersEnabled,
                onChanged: onToggleReminders,
                activeColor: scheme.primary,
              ),
            ],
          ),
          if (remindersEnabled) ...<Widget>[
            const SizedBox(height: 12),
            _TimeTile(
              label: 'Watering Reminder',
              time: waterTime,
              onTap: onPickWaterTime,
              icon: Icons.water_drop_rounded,
              color: Colors.blue.shade400,
              onSurface: onSurface,
            ),
            const SizedBox(height: 8),
            _TimeTile(
              label: 'Feeding Reminder',
              time: feedTime,
              onTap: onPickFeedTime,
              icon: Icons.grass_rounded,
              color: Colors.green.shade500,
              onSurface: onSurface,
            ),
          ] else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Reminders are disabled for this plant.',
                style: TextStyle(
                  fontSize: 12,
                  color: onSurface.withValues(alpha: 0.4),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TimeTile extends StatelessWidget {
  const _TimeTile({
    required this.label,
    required this.time,
    required this.onTap,
    required this.icon,
    required this.color,
    required this.onSurface,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: onSurface.withValues(alpha: 0.1)),
          color: isDark
              ? Colors.white.withValues(alpha: 0.03)
              : Colors.black.withValues(alpha: 0.02),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: onSurface,
                ),
              ),
            ),
            Text(
              time.format(context),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.edit_calendar_rounded,
              size: 14,
              color: onSurface.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}
