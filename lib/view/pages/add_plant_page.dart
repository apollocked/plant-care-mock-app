import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';
import 'package:mock_plant_care_app/viewmodel/plant_viewmodel.dart';
import 'package:provider/provider.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _waterDaysController = TextEditingController(
    text: '2',
  );
  final TextEditingController _feedDaysController = TextEditingController(
    text: '7',
  );

  TimeOfDay _waterTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _feedTime = const TimeOfDay(hour: 10, minute: 0);
  bool _remindersEnabled = true;

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _waterDaysController.dispose();
    _feedDaysController.dispose();
    super.dispose();
  }

  Future<void> _pickTime({required bool water}) async {
    final TimeOfDay initial = water ? _waterTime : _feedTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (picked == null) {
      return;
    }
    setState(() {
      if (water) {
        _waterTime = picked;
      } else {
        _feedTime = picked;
      }
    });
  }

  Future<void> _savePlant() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final PlantModel plant = PlantModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      species: _speciesController.text.trim().isEmpty
          ? null
          : _speciesController.text.trim(),
      waterIntervalDays: int.parse(_waterDaysController.text),
      feedIntervalDays: int.parse(_feedDaysController.text),
      waterReminderHour: _waterTime.hour,
      waterReminderMinute: _waterTime.minute,
      feedReminderHour: _feedTime.hour,
      feedReminderMinute: _feedTime.minute,
      remindersEnabled: _remindersEnabled,
    );

    await context.read<PlantViewModel>().addPlant(plant);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Add Plant')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.16),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Plant Name',
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a plant name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _speciesController,
                      decoration: const InputDecoration(
                        labelText: 'Species (optional)',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _waterDaysController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Water Interval (days)',
                      ),
                      validator: _validatePositiveInt,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _feedDaysController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Feed Interval (days)',
                      ),
                      validator: _validatePositiveInt,
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      value: _remindersEnabled,
                      title: const Text('Daily reminders'),
                      onChanged: (bool value) {
                        setState(() => _remindersEnabled = value);
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Water reminder time'),
                      subtitle: Text(_waterTime.format(context)),
                      trailing: TextButton(
                        onPressed: () => _pickTime(water: true),
                        child: const Text('Change'),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Food reminder time'),
                      subtitle: Text(_feedTime.format(context)),
                      trailing: TextButton(
                        onPressed: () => _pickTime(water: false),
                        child: const Text('Change'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _savePlant,
                        child: const Text('Save Plant'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePositiveInt(String? value) {
    final int? parsed = int.tryParse(value ?? '');
    if (parsed == null || parsed <= 0) {
      return 'Enter a number greater than 0';
    }
    return null;
  }
}
