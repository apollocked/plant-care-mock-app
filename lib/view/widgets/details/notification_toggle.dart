import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';
import 'package:mock_plant_care_app/viewmodel/plant_viewmodel.dart';

class NotificationToggleCard extends StatelessWidget {
  const NotificationToggleCard({
    super.key,
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
            activeColor: scheme.primary,
            onChanged: (_) => _toggle(context),
          ),
        ],
      ),
    );
  }
}
