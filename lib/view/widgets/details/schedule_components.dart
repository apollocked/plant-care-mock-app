import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleRow extends StatelessWidget {
  const ScheduleRow({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.onSurface,
    this.onEdit,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final Color onSurface;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
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
            if (onEdit != null) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.edit_outlined,
                size: 14,
                color: onSurface.withValues(alpha: 0.2),
              ),
            ],
          ],
        ),
      ),
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
