// lib/core/notfications/notfication_controler.dart
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/main.dart';
import 'package:mock_plant_care_app/ui/pages/plant_stats_page.dart';

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // 1. Handle iOS Badge Logic
    if (receivedAction.channelKey == 'basic_channel' && Platform.isIOS) {
      int badgeCount = await AwesomeNotifications().getGlobalBadgeCounter();
      await AwesomeNotifications().setGlobalBadgeCounter(badgeCount - 1);
    }

    // 2. Navigate using the Global Key
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const PlantStatsPage()),
      (route) => route.isFirst,
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification n,
  ) async {}
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification n,
  ) async {}
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction a) async {}
}
