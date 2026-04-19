import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/view/widgets/add/identity_section.dart';
import 'package:mock_plant_care_app/view/widgets/add/schedule_section.dart';
import 'package:mock_plant_care_app/view/widgets/add/reminder_section.dart';
import 'package:mock_plant_care_app/viewmodel/plant_viewmodel.dart';
import 'package:provider/provider.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _speciesCtrl = TextEditingController();
  final TextEditingController _waterDaysCtrl = TextEditingController(text: '2');
  final TextEditingController _feedDaysCtrl = TextEditingController(text: '7');

  TimeOfDay _waterTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _feedTime = const TimeOfDay(hour: 10, minute: 0);
  bool _remindersEnabled = true;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _speciesCtrl.dispose();
    _waterDaysCtrl.dispose();
    _feedDaysCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickTime({required bool water}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: water ? _waterTime : _feedTime,
    );
    if (picked == null) return;
    setState(() => water ? _waterTime = picked : _feedTime = picked);
  }

  Future<void> _savePlant() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final PlantModel plant = PlantModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: _nameCtrl.text.trim(),
      species: _speciesCtrl.text.trim().isEmpty ? null : _speciesCtrl.text.trim(),
      waterIntervalDays: int.parse(_waterDaysCtrl.text),
      feedIntervalDays: int.parse(_feedDaysCtrl.text),
      waterReminderHour: _waterTime.hour,
      waterReminderMinute: _waterTime.minute,
      feedReminderHour: _feedTime.hour,
      feedReminderMinute: _feedTime.minute,
      remindersEnabled: _remindersEnabled,
    );
    await context.read<PlantViewModel>().addPlant(plant);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color onSurface = scheme.onSurface;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: onSurface),
        title: Row(
          children: <Widget>[
            Image.asset('assets/icons/plant_icon.png', width: 28, height: 28),
            const SizedBox(width: 10),
            Text('Add New Plant',
                style: TextStyle(color: onSurface, fontWeight: FontWeight.w700, fontSize: 17)),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const <double>[0.0, 0.4, 1.0],
            colors: <Color>[
              scheme.primary.withValues(alpha: isDark ? 0.25 : 0.1),
              scheme.primary.withValues(alpha: isDark ? 0.08 : 0.03),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              child: Column(
                children: <Widget>[
                  PlantIdentitySection(
                    nameCtrl: _nameCtrl,
                    speciesCtrl: _speciesCtrl,
                    onSurface: onSurface,
                  ),
                  const SizedBox(height: 16),
                  CareScheduleSection(
                    waterDaysCtrl: _waterDaysCtrl,
                    feedDaysCtrl: _feedDaysCtrl,
                    onSurface: onSurface,
                  ),
                  const SizedBox(height: 16),
                  ReminderSection(
                    remindersEnabled: _remindersEnabled,
                    waterTime: _waterTime,
                    feedTime: _feedTime,
                    onToggleReminders: (bool v) => setState(() => _remindersEnabled = v),
                    onPickWaterTime: () => _pickTime(water: true),
                    onPickFeedTime: () => _pickTime(water: false),
                    onSurface: onSurface,
                  ),
                  const SizedBox(height: 28),
                  // Gradient save button
                  GestureDetector(
                    onTap: _isSaving ? null : _savePlant,
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: <Color>[
                            scheme.primary,
                            Color.lerp(scheme.primary, Colors.teal, 0.45)!,
                          ],
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: scheme.primary.withValues(alpha: 0.4),
                            blurRadius: 18,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _isSaving
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.local_florist_outlined, color: Colors.white, size: 20),
                                  SizedBox(width: 10),
                                  Text('Save Plant',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

