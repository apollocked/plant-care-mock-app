import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mock_plant_care_app/core/models/plant_model.dart';
import 'package:mock_plant_care_app/viewmodels/plant_viewmodel.dart';
import 'package:provider/provider.dart';

class PlantDetailsPage extends StatelessWidget {
  const PlantDetailsPage({super.key, required this.plantId});

  final String plantId;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantViewModel>(
      builder: (BuildContext context, PlantViewModel vm, _) {
        final PlantModel? plant = vm.getPlantById(plantId);
        if (plant == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Plant Details')),
            body: const Center(child: Text('Plant not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(plant.name),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  await vm.deletePlant(plant.id);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: <Widget>[
                        const CircleAvatar(
                          radius: 24,
                          child: Icon(Icons.energy_savings_leaf_outlined),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                plant.species == null || plant.species!.isEmpty
                                    ? 'No species set'
                                    : plant.species!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Daily reminders: ${plant.remindersEnabled ? 'On' : 'Off'}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: <Widget>[
                        _InfoRow(
                          title: 'Water due',
                          value: DateFormat.yMMMd().add_jm().format(plant.nextWaterDue),
                        ),
                        _InfoRow(
                          title: 'Food due',
                          value: DateFormat.yMMMd().add_jm().format(plant.nextFoodDue),
                        ),
                        _InfoRow(
                          title: 'Needs water now',
                          value: plant.needsWaterNow ? 'Yes' : 'No',
                        ),
                        _InfoRow(
                          title: 'Needs food now',
                          value: plant.needsFoodNow ? 'Yes' : 'No',
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => vm.markPlantWatered(plant.id),
                        icon: const Icon(Icons.water_drop_outlined),
                        label: const Text('Watered Now'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => vm.markPlantFed(plant.id),
                        icon: const Icon(Icons.local_florist_outlined),
                        label: const Text('Fed Now'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(title), Text(value)],
      ),
    );
  }
}
