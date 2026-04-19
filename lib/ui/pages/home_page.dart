// ignore_for_file: use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/core/notfications/notifications.dart';
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

    // Use the WidgetsBinding to ensure the context is ready before showing a dialog
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNotificationPermission();
    });
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
        title: Text("My Plant", style: TextTheme.of(context).bodyMedium),
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
                return null;
              },
              onPressedThree: () async {
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
