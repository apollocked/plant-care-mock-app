import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/core/models/plant_model.dart';
import 'package:mock_plant_care_app/core/notfications/notifications.dart';

class NotificationService {
  Future<void> initialize() async {
    await AwesomeNotifications().initialize('resource://drawable/res_notification_app_icon', [
      NotificationChannel(
        channelKey: basicChannelKey,
        channelName: 'Basic notifications',
        channelDescription: 'General plant notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.Max,
        enableVibration: true,
        playSound: true,
        soundSource: 'resource://raw/res_custom_notification',
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: scheduledChannelKey,
        channelName: 'Scheduled notifications',
        channelDescription: 'Daily plant reminders',
        defaultColor: Colors.teal,
        importance: NotificationImportance.Max,
        enableVibration: true,
        playSound: true,
        soundSource: 'resource://raw/res_custom_notification',
        channelShowBadge: true,
      ),
    ]);
  }

  Future<void> ensurePermission() async {
    final bool allowed = await AwesomeNotifications().isNotificationAllowed();
    if (!allowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  Future<void> scheduleDailyWaterReminder(PlantModel plant) async {
    await createPlantReminderNotification(
      id: notificationIdForPlant(plant.id, PlantReminderType.water),
      plantId: plant.id,
      plantName: plant.name,
      type: PlantReminderType.water,
      hour: plant.waterReminderHour,
      minute: plant.waterReminderMinute,
    );
  }

  Future<void> scheduleDailyFeedReminder(PlantModel plant) async {
    await createPlantReminderNotification(
      id: notificationIdForPlant(plant.id, PlantReminderType.food),
      plantId: plant.id,
      plantName: plant.name,
      type: PlantReminderType.food,
      hour: plant.feedReminderHour,
      minute: plant.feedReminderMinute,
    );
  }

  Future<void> cancelPlantReminders(String plantId) async {
    await cancelPlantNotifications(plantId);
  }
}
