import 'package:flutter/material.dart';

class FormSectionHeader extends StatelessWidget {
  const FormSectionHeader({
    super.key,
    required this.icon,
    required this.label,
    required this.onSurface,
  });

  final String icon;
  final String label;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

String? validatePositiveInt(String? v) {
  if (v == null || v.isEmpty) return 'Required';
  final int? val = int.tryParse(v);
  if (val == null || val <= 0) return 'Must be > 0';
  return null;
}
