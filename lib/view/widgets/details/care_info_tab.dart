import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';

class CareInfoTab extends StatelessWidget {
  const CareInfoTab({super.key, required this.plant});

  final PlantModel plant;

  String _timeAgo(DateTime dt) {
    final Duration d = DateTime.now().difference(dt);
    if (d.inDays > 0) return '${d.inDays}d ago';
    if (d.inHours > 0) return '${d.inHours}h ago';
    return 'just now';
  }

  @override
  Widget build(BuildContext context) {
    final Color onSurface = Theme.of(context).colorScheme.onSurface;

    final List<Map<String, String>> tips = <Map<String, String>>[
      {
        'icon': '💧',
        'text':
            'Water every ${plant.waterIntervalDays} day${plant.waterIntervalDays > 1 ? 's' : ''} for best results.',
      },
      {
        'icon': '🌿',
        'text':
            'Feed every ${plant.feedIntervalDays} day${plant.feedIntervalDays > 1 ? 's' : ''} to keep it growing strong.',
      },
      {'icon': '☀️', 'text': 'Ensure adequate indirect sunlight every day.'},
      {
        'icon': '🌡️',
        'text': 'Keep temperature stable — avoid cold drafts and direct heat.',
      },
      {
        'icon': '🪴',
        'text':
            'Check for pests regularly and wipe leaves for better photosynthesis.',
      },
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CareStatusCard(
            icon: Icons.water_drop_outlined,
            color: Colors.blue,
            title: 'Watering',
            okLabel: 'Watered ✓',
            urgentLabel: 'Water Now!',
            isUrgent: plant.needsWaterNow,
            lastActionLabel: 'Last watered ${_timeAgo(plant.lastWateredAt)}',
            nextDueLabel:
                'Next: ${DateFormat('MMM d, h:mm a').format(plant.nextWaterDue)}',
            intervalLabel: 'Every ${plant.waterIntervalDays}d',
            onSurface: onSurface,
          ),
          const SizedBox(height: 12),
          CareStatusCard(
            icon: Icons.grass_outlined,
            color: Colors.orange,
            title: 'Feeding',
            okLabel: 'Fed ✓',
            urgentLabel: 'Feed Now!',
            isUrgent: plant.needsFoodNow,
            lastActionLabel: 'Last fed ${_timeAgo(plant.lastFedAt)}',
            nextDueLabel:
                'Next: ${DateFormat('MMM d, h:mm a').format(plant.nextFoodDue)}',
            intervalLabel: 'Every ${plant.feedIntervalDays}d',
            onSurface: onSurface,
          ),
          const SizedBox(height: 20),
          Text(
            '💡 Care Tips',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 10),
          ...tips.map(
            (Map<String, String> t) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GlassContainer(
                borderRadius: 14,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: <Widget>[
                    Text(t['icon']!, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        t['text']!,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: onSurface.withValues(alpha: 0.75),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CareStatusCard extends StatelessWidget {
  const CareStatusCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.okLabel,
    required this.urgentLabel,
    required this.isUrgent,
    required this.lastActionLabel,
    required this.nextDueLabel,
    required this.intervalLabel,
    required this.onSurface,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String okLabel;
  final String urgentLabel;
  final bool isUrgent;
  final String lastActionLabel;
  final String nextDueLabel;
  final String intervalLabel;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    final Color active = isUrgent ? color : Colors.green;
    return GlassContainer(
      borderRadius: 18,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: onSurface,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: active.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: active.withValues(alpha: 0.3)),
                ),
                child: Text(
                  isUrgent ? urgentLabel : okLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: active,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: isUrgent ? 1.0 : 0.55,
              backgroundColor: active.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(active),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Icon(
                Icons.history_rounded,
                size: 13,
                color: onSurface.withValues(alpha: 0.4),
              ),
              const SizedBox(width: 5),
              Text(
                lastActionLabel,
                style: TextStyle(
                  fontSize: 12,
                  color: onSurface.withValues(alpha: 0.6),
                ),
              ),
              const Spacer(),
              Text(
                intervalLabel,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            nextDueLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isUrgent ? FontWeight.w600 : FontWeight.w400,
              color: isUrgent ? color : onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
