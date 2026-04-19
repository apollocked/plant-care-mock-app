import 'package:flutter/material.dart';

class PlantModel {
  PlantModel({
    required this.id,
    required this.name,
    required this.waterIntervalDays,
    required this.feedIntervalDays,
    required this.waterReminderHour,
    required this.waterReminderMinute,
    required this.feedReminderHour,
    required this.feedReminderMinute,
    this.species,
    this.imagePath,
    DateTime? lastWateredAt,
    DateTime? lastFedAt,
    this.remindersEnabled = true,
  }) : lastWateredAt = lastWateredAt ?? DateTime.now(),
       lastFedAt = lastFedAt ?? DateTime.now();

  final String id;
  String name;
  String? species;
  String? imagePath;
  DateTime lastWateredAt;
  DateTime lastFedAt;
  int waterIntervalDays;
  int feedIntervalDays;
  int waterReminderHour;
  int waterReminderMinute;
  int feedReminderHour;
  int feedReminderMinute;
  bool remindersEnabled;

  bool get needsWaterNow =>
      DateTime.now().isAfter(lastWateredAt.add(Duration(days: waterIntervalDays)));

  bool get needsFoodNow =>
      DateTime.now().isAfter(lastFedAt.add(Duration(days: feedIntervalDays)));

  DateTime get nextWaterDue => lastWateredAt.add(Duration(days: waterIntervalDays));

  DateTime get nextFoodDue => lastFedAt.add(Duration(days: feedIntervalDays));

  TimeOfDay get waterReminderTime =>
      TimeOfDay(hour: waterReminderHour, minute: waterReminderMinute);

  TimeOfDay get feedReminderTime =>
      TimeOfDay(hour: feedReminderHour, minute: feedReminderMinute);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'species': species,
      'imagePath': imagePath,
      'lastWateredAt': lastWateredAt.toIso8601String(),
      'lastFedAt': lastFedAt.toIso8601String(),
      'waterIntervalDays': waterIntervalDays,
      'feedIntervalDays': feedIntervalDays,
      'waterReminderHour': waterReminderHour,
      'waterReminderMinute': waterReminderMinute,
      'feedReminderHour': feedReminderHour,
      'feedReminderMinute': feedReminderMinute,
      'remindersEnabled': remindersEnabled,
    };
  }

  factory PlantModel.fromMap(Map<dynamic, dynamic> map) {
    return PlantModel(
      id: map['id'] as String,
      name: map['name'] as String,
      species: map['species'] as String?,
      imagePath: map['imagePath'] as String?,
      lastWateredAt: DateTime.parse(map['lastWateredAt'] as String),
      lastFedAt: DateTime.parse(map['lastFedAt'] as String),
      waterIntervalDays: map['waterIntervalDays'] as int,
      feedIntervalDays: map['feedIntervalDays'] as int,
      waterReminderHour: map['waterReminderHour'] as int,
      waterReminderMinute: map['waterReminderMinute'] as int,
      feedReminderHour: map['feedReminderHour'] as int,
      feedReminderMinute: map['feedReminderMinute'] as int,
      remindersEnabled: (map['remindersEnabled'] as bool?) ?? true,
    );
  }
}
