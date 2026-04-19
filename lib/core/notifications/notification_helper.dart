import 'package:awesome_notifications/awesome_notifications.dart';

const String basicChannelKey = 'basic_channel';
const String scheduledChannelKey = 'scheduled_channel';

enum PlantReminderType { water, food }

int notificationIdForPlant(String plantId, PlantReminderType type) {
  final int hash = plantId.hashCode.abs().remainder(99999);
  if (type == PlantReminderType.water) {
    return hash * 10 + 1;
  }
  return hash * 10 + 2;
}

Future<void> createPlantReminderNotification({
  required int id,
  required String plantId,
  required String plantName,
  required PlantReminderType type,
  required int hour,
  required int minute,
}) async {
  final bool isWater = type == PlantReminderType.water;
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: scheduledChannelKey,
      title: isWater
          ? '${Emojis.wheater_droplet} Water $plantName'
          : '${Emojis.plant_cactus} Feed $plantName',
      body: isWater
          ? '$plantName needs water now.'
          : '$plantName is ready for plant food.',
      notificationLayout: NotificationLayout.Default,
      payload: <String, String>{
        'plantId': plantId,
        'reminderType': type.name,
      },
    ),
    actionButtons: [
      NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done'),
    ],
    schedule: NotificationCalendar(
      hour: hour,
      minute: minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}

Future<void> cancelPlantNotifications(String plantId) async {
  await AwesomeNotifications().cancel(
    notificationIdForPlant(plantId, PlantReminderType.water),
  );
  await AwesomeNotifications().cancel(
    notificationIdForPlant(plantId, PlantReminderType.food),
  );
}
