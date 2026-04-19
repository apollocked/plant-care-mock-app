import 'package:flutter/material.dart';

class UrgentBanner extends StatelessWidget {
  const UrgentBanner({super.key, required this.urgentCount});

  final int urgentCount;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: <Color>[
            Colors.orange.withValues(alpha: isDark ? 0.25 : 0.15),
            Colors.red.withValues(alpha: isDark ? 0.15 : 0.08),
          ],
        ),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$urgentCount plant${urgentCount > 1 ? 's' : ''} need care',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  'Tap a plant card to take action',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.orange.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
