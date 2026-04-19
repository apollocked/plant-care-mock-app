import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageButtons extends StatelessWidget {
  final Future<void> Function() onPressedOne;
  final Future<void> Function() onPressedTwo;
  final Future<void> Function() onPressedThree;

  const HomePageButtons({
    super.key,
    required this.onPressedOne,
    required this.onPressedTwo,
    required this.onPressedThree,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          _buildActionButton(
            label: 'Food',
            icon: FontAwesomeIcons.leaf,
            color: Colors.teal.shade700,
            onTap: onPressedOne,
          ),
          const SizedBox(width: 12),
          _buildActionButton(
            label: 'Water',
            icon: FontAwesomeIcons.droplet,
            color: Colors.blue.shade600,
            onTap: onPressedTwo,
          ),
          const SizedBox(width: 12),
          _buildActionButton(
            label: 'Cancel',
            icon: FontAwesomeIcons.xmark,
            color: Colors.red.shade400,
            onTap: onPressedThree,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required dynamic icon, // Changed to dynamic to accept any IconData type
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.2), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // We cast it to IconData inside the widget to satisfy FaIcon
              FaIcon(icon, size: 18, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
