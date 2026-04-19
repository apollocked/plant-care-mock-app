import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';
import 'package:mock_plant_care_app/viewmodel/plant_viewmodel.dart';

class ScheduleTab extends StatelessWidget {
  const ScheduleTab({super.key, required this.plant, required this.vm});

  final PlantModel plant;
  final PlantViewModel vm;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color onSurface = scheme.onSurface;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        children: <Widget>[
          _ScheduleInfoCard(
            title: '⏰ Reminder Times',
            onSurface: onSurface,
            children: <Widget>[
              ScheduleRow(
                icon: Icons.water_drop_outlined,
                color: Colors.blue,
                label: 'Water Reminder',
                value: plant.waterReminderTime.format(context),
                onSurface: onSurface,
              ),
              const Divider(height: 20),
              ScheduleRow(
                icon: Icons.grass_outlined,
                color: Colors.orange,
                label: 'Feed Reminder',
                value: plant.feedReminderTime.format(context),
                onSurface: onSurface,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _ScheduleInfoCard(
            title: '🔁 Care Intervals',
            onSurface: onSurface,
            children: <Widget>[
              ScheduleRow(
                icon: Icons.water_drop_outlined,
                color: Colors.blue,
                label: 'Watering',
                value:
                    'Every ${plant.waterIntervalDays} day${plant.waterIntervalDays > 1 ? 's' : ''}',
                onSurface: onSurface,
              ),
              const Divider(height: 20),
              ScheduleRow(
                icon: Icons.grass_outlined,
                color: Colors.orange,
                label: 'Feeding',
                value:
                    'Every ${plant.feedIntervalDays} day${plant.feedIntervalDays > 1 ? 's' : ''}',
                onSurface: onSurface,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _ScheduleInfoCard(
            title: '📅 Upcoming Dates',
            onSurface: onSurface,
            children: <Widget>[
              UpcomingDateRow(
                icon: Icons.water_drop_outlined,
                color: Colors.blue,
                label: 'Next watering',
                date: plant.nextWaterDue,
                isOverdue: plant.needsWaterNow,
                onSurface: onSurface,
              ),
              const Divider(height: 20),
              UpcomingDateRow(
                icon: Icons.grass_outlined,
                color: Colors.orange,
                label: 'Next feeding',
                date: plant.nextFoodDue,
                isOverdue: plant.needsFoodNow,
                onSurface: onSurface,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _NotificationToggleCard(
            plant: plant,
            vm: vm,
            scheme: scheme,
            onSurface: onSurface,
          ),
        ],
      ),
    );
  }
}

// ─── Reusable card wrapper ────────────────────────────────────────────────────

class _ScheduleInfoCard extends StatelessWidget {
  const _ScheduleInfoCard({
    required this.title,
    required this.onSurface,
    required this.children,
  });

  final String title;
  final Color onSurface;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 18,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

// ─── Notification toggle card (tappable) ─────────────────────────────────────

class _NotificationToggleCard extends StatelessWidget {
  const _NotificationToggleCard({
    required this.plant,
    required this.vm,
    required this.scheme,
    required this.onSurface,
  });

  final PlantModel plant;
  final PlantViewModel vm;
  final ColorScheme scheme;
  final Color onSurface;

  Future<void> _toggle(BuildContext context) async {
    plant.remindersEnabled = !plant.remindersEnabled;
    await vm.updatePlant(plant);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            plant.remindersEnabled
                ? '🔔 Reminders turned ON for ${plant.name}'
                : '🔕 Reminders turned OFF for ${plant.name}',
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool on = plant.remindersEnabled;
    return GlassContainer(
      borderRadius: 18,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (on ? scheme.primary : Colors.grey).withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              on
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_off_outlined,
              color: on ? scheme.primary : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Push Reminders',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: onSurface,
                  ),
                ),
                Text(
                  on
                      ? 'Daily notifications are active'
                      : 'Tap to enable notifications',
                  style: TextStyle(
                    fontSize: 12,
                    color: onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: on,
            // ignore: deprecated_member_use
            activeColor: scheme.primary,
            onChanged: (_) => _toggle(context),
          ),
        ],
      ),
    );
  }
}

// ─── Shared row widgets ───────────────────────────────────────────────────────

class ScheduleRow extends StatelessWidget {
  const ScheduleRow({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.onSurface,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: onSurface.withValues(alpha: 0.7),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class UpcomingDateRow extends StatelessWidget {
  const UpcomingDateRow({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.date,
    required this.isOverdue,
    required this.onSurface,
  });

  final IconData icon;
  final Color color;
  final String label;
  final DateTime date;
  final bool isOverdue;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    final Color active = isOverdue ? Colors.red : color;
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: active.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 14, color: active),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: onSurface.withValues(alpha: 0.7),
                ),
              ),
              if (isOverdue)
                const Text(
                  'Overdue!',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        Text(
          DateFormat('MMM d, h:mm a').format(date),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active,
          ),
        ),
      ],
    );
  }
}
