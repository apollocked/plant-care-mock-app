import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/viewmodel/plant_viewmodel.dart';

class DetailsActionBar extends StatelessWidget {
  const DetailsActionBar({
    super.key,
    required this.plant,
    required this.vm,
    required this.isDark,
  });

  final PlantModel plant;
  final PlantViewModel vm;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0E1C1D).withValues(alpha: 0.96)
            : Colors.white.withValues(alpha: 0.96),
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.07),
          ),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.07),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GradientActionButton(
              label: 'Watered!',
              icon: Icons.water_drop_rounded,
              colors: <Color>[Colors.blue.shade400, Colors.blue.shade700],
              shadowColor: Colors.blue,
              onTap: () async {
                await vm.markPlantWatered(plant.id);
                if (context.mounted) {
                  _snack(context, '💧 ${plant.name} has been watered!');
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GradientActionButton(
              label: 'Fed!',
              icon: Icons.grass_rounded,
              colors: <Color>[Colors.green.shade500, Colors.teal.shade600],
              shadowColor: Colors.green,
              onTap: () async {
                await vm.markPlantFed(plant.id);
                if (context.mounted) {
                  _snack(context, '🌿 ${plant.name} has been fed!');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _snack(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class GradientActionButton extends StatelessWidget {
  const GradientActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.colors,
    required this.shadowColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final List<Color> colors;
  final Color shadowColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: colors),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: shadowColor.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
