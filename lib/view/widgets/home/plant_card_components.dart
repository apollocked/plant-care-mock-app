import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'quick_action_button.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.plant,
    required this.healthScore,
    required this.healthColor,
    required this.healthLabel,
    required this.onSurface,
  });

  final PlantModel plant;
  final double healthScore;
  final Color healthColor;
  final String healthLabel;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: 52,
              height: 52,
              child: CircularProgressIndicator(
                value: healthScore,
                strokeWidth: 3,
                backgroundColor: healthColor.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(healthColor),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: healthColor.withValues(alpha: 0.12),
              ),
              padding: const EdgeInsets.all(6),
              child: Image.asset('assets/icons/plant_icon.png', fit: BoxFit.contain),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                plant.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                plant.species ?? 'Unknown species',
                style: TextStyle(
                  fontSize: 12,
                  color: onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: healthColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: healthColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: healthColor),
              ),
              const SizedBox(width: 5),
              Text(
                healthLabel,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: healthColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardActions extends StatelessWidget {
  const CardActions({
    super.key,
    required this.plant,
    required this.scheme,
    required this.onWaterTap,
    required this.onFeedTap,
  });

  final PlantModel plant;
  final ColorScheme scheme;
  final VoidCallback onWaterTap;
  final VoidCallback onFeedTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: QuickActionButton(
            label: plant.needsWaterNow ? 'Water Now' : 'Water ok',
            icon: Icons.water_drop_outlined,
            color: plant.needsWaterNow ? Colors.blue : scheme.primary,
            urgent: plant.needsWaterNow,
            onTap: plant.needsWaterNow ? onWaterTap : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: QuickActionButton(
            label: plant.needsFoodNow ? 'Feed Now' : 'Food ok',
            icon: Icons.grass_outlined,
            color: plant.needsFoodNow ? Colors.orange : Colors.green,
            urgent: plant.needsFoodNow,
            onTap: plant.needsFoodNow ? onFeedTap : null,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scheme.primary.withValues(alpha: 0.1),
          ),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: scheme.primary,
          ),
        ),
      ],
    );
  }
}


