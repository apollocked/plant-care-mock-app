import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';
import 'form_helpers.dart';

class PlantIdentitySection extends StatelessWidget {
  const PlantIdentitySection({
    super.key,
    required this.nameCtrl,
    required this.speciesCtrl,
    required this.onSurface,
  });

  final TextEditingController nameCtrl;
  final TextEditingController speciesCtrl;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormSectionHeader(icon: '🌱', label: 'Plant Identity', onSurface: onSurface),
          const SizedBox(height: 16),
          TextFormField(
            controller: nameCtrl,
            style: TextStyle(color: onSurface),
            decoration: const InputDecoration(
              labelText: 'Plant Name',
              hintText: 'e.g. My Fiddle Leaf',
              prefixIcon: Icon(Icons.badge_outlined, size: 20),
            ),
            validator: (String? v) => (v == null || v.trim().isEmpty) ? 'Please enter a name' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: speciesCtrl,
            style: TextStyle(color: onSurface),
            decoration: const InputDecoration(
              labelText: 'Species (Optional)',
              hintText: 'e.g. Monstera Deliciosa',
              prefixIcon: Icon(Icons.eco_outlined, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
