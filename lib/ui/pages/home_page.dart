// ignore_for_file: use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/core/notfications/notfication_controler.dart';
import 'package:mock_plant_care_app/core/notfications/notifications.dart';
import 'package:mock_plant_care_app/core/utils/utilities.dart';
import 'package:mock_plant_care_app/ui/pages/plant_stats_page.dart';
import 'package:mock_plant_care_app/ui/widgets/app_tile.dart';
import 'package:mock_plant_care_app/ui/widgets/home_page_buttons.dart';
import 'package:mock_plant_care_app/ui/widgets/notfication_handler.dart';
import 'package:mock_plant_care_app/ui/widgets/plant_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNotificationPermission();
    });
    AwesomeNotifications().setListeners(
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _checkNotificationPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Call the static method from the other file
        NotificationPermissionHandler.showPermissionDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: AppBarTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PlantStatsPage()),
              );
            },
            icon: Icon(
              Icons.insert_chart_outlined_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            plantImage(),
            const SizedBox(height: 25),
            HomePageButtons(
              onPressedOne: createPlantFoodNotification,
              onPressedTwo: () async {
                // Corrected variable name and syntax
                NotificationWeekAndTime? pickedSchedule = await pickSchedule(
                  context,
                );

                if (pickedSchedule != null) {
                  await createWaterReminderNotification(pickedSchedule);
                }
              },
              onPressedThree: () async {
                await cancelScheduledNotifications();
              },
            ),
          ],
        ),
      ),
    );
  }
}
