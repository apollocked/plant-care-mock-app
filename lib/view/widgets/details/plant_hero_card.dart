import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';

class PlantHeroCard extends StatelessWidget {
  const PlantHeroCard({super.key, required this.plant});

  final PlantModel plant;

  double _healthScore() {
    if (!plant.needsWaterNow && !plant.needsFoodNow) return 1.0;
    if (plant.needsWaterNow && plant.needsFoodNow) return 0.2;
    return 0.6;
  }

  Color _healthColor() {
    final double s = _healthScore();
    if (s >= 0.9) return Colors.green;
    if (s >= 0.5) return Colors.orange;
    return Colors.red;
  }

  String _healthLabel() {
    final double s = _healthScore();
    if (s >= 0.9) return 'Thriving 🌟';
    if (s >= 0.5) return 'Needs Care';
    return 'Urgent! 🚨';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color onSurface = scheme.onSurface;

    return GlassContainer(
      borderRadius: 22,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: <Widget>[
          _HealthRing(healthScore: _healthScore(), healthColor: _healthColor()),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  plant.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  plant.species?.isNotEmpty == true
                      ? plant.species!
                      : 'Unknown species',
                  style: TextStyle(
                    fontSize: 13,
                    color: onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: <Widget>[
                    StatusPill(label: _healthLabel(), color: _healthColor()),
                    StatusPill(
                      label: plant.remindersEnabled
                          ? '🔔 Reminders on'
                          : '🔕 Off',
                      color: scheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HealthRing extends StatelessWidget {
  const _HealthRing({required this.healthScore, required this.healthColor});

  final double healthScore;
  final Color healthColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          width: 72,
          height: 72,
          child: CircularProgressIndicator(
            value: healthScore,
            strokeWidth: 4,
            backgroundColor: healthColor.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation<Color>(healthColor),
          ),
        ),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: healthColor.withValues(alpha: 0.1),
          ),
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            'assets/icons/plant_icon.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
