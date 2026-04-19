import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';
import 'package:mock_plant_care_app/viewmodel/plant_viewmodel.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key, required this.plantVm});

  final PlantViewModel plantVm;

  @override
  Widget build(BuildContext context) {
    final int total = plantVm.plants.length;
    final int needWater = plantVm.plants.where((p) => p.needsWaterNow).length;
    final int needFood = plantVm.plants.where((p) => p.needsFoodNow).length;
    final int happy = total -
        plantVm.plants
            .where((p) => p.needsWaterNow || p.needsFoodNow)
            .length;
    final Color primary = Theme.of(context).colorScheme.primary;

    return Row(
      children: <Widget>[
        Expanded(child: _StatCard(value: '$total', label: 'Total', icon: Icons.local_florist_outlined, color: primary)),
        const SizedBox(width: 10),
        Expanded(child: _StatCard(value: '$happy', label: 'Healthy', icon: Icons.favorite_outline_rounded, color: Colors.green)),
        const SizedBox(width: 10),
        Expanded(child: _StatCard(value: '$needWater', label: 'Water', icon: Icons.water_drop_outlined, color: Colors.blue)),
        const SizedBox(width: 10),
        Expanded(child: _StatCard(value: '$needFood', label: 'Feed', icon: Icons.grass_outlined, color: Colors.orange)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color onSurface = Theme.of(context).colorScheme.onSurface;

    return GlassContainer(
      borderRadius: 16,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDark ? 0.2 : 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: onSurface,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

