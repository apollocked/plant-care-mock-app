import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/main.dart';
import 'package:mock_plant_care_app/view/pages/home_page.dart';
import 'package:mock_plant_care_app/view/pages/plant_details_page.dart';

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    if (receivedAction.channelKey == 'basic_channel' && Platform.isIOS) {
      int badgeCount = await AwesomeNotifications().getGlobalBadgeCounter();
      await AwesomeNotifications().setGlobalBadgeCounter(badgeCount - 1);
    }

    final String? plantId = receivedAction.payload?['plantId'];
    if (plantId == null || plantId.isEmpty) {
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => route.isFirst,
      );
      return;
    }

    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => PlantDetailsPage(plantId: plantId)),
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
