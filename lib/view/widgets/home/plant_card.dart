import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';
import 'package:mock_plant_care_app/view/widgets/home/plant_card_components.dart';

class PlantCard extends StatefulWidget {
  const PlantCard({
    super.key,
    required this.plant,
    required this.onTap,
    required this.onWaterTap,
    required this.onFeedTap,
  });

  final PlantModel plant;
  final VoidCallback onTap;
  final VoidCallback onWaterTap;
  final VoidCallback onFeedTap;

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.97,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _healthScore() {
    if (!widget.plant.needsWaterNow && !widget.plant.needsFoodNow) return 1.0;
    if (widget.plant.needsWaterNow && widget.plant.needsFoodNow) return 0.2;
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
    if (s >= 0.9) return 'Thriving';
    if (s >= 0.5) return 'Needs care';
    return 'Urgent!';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) =>
          Transform.scale(scale: _controller.value, child: child),
      child: GlassContainer(
        borderRadius: 20,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: widget.onTap,
          onTapDown: (_) => _controller.reverse(),
          onTapUp: (_) => _controller.forward(),
          onTapCancel: () => _controller.forward(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CardHeader(
                  plant: widget.plant,
                  healthScore: _healthScore(),
                  healthColor: _healthColor(),
                  healthLabel: _healthLabel(),
                  onSurface: scheme.onSurface,
                ),
                const SizedBox(height: 14),
                CardActions(
                  plant: widget.plant,
                  scheme: scheme,
                  onWaterTap: widget.onWaterTap,
                  onFeedTap: widget.onFeedTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
