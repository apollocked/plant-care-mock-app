import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/ui/pages/home_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications()
      .initialize('resource://drawable/res_notification_app_icon', [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',

          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.teal,
          importance: NotificationImportance.Max,
          enableVibration: true,
          playSound: true,
          soundSource: 'resource://raw/res_custom_notification',
          channelShowBadge: true,
        ),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled notifications',
          channelDescription: 'Notification channel for scheduled tests',
          defaultColor: Colors.teal,
          importance: NotificationImportance.Max,
          locked: true,
          enableVibration: true,
          playSound: true,
          channelShowBadge: true,
          soundSource: 'resource://raw/res_custom_notification',
        ),
      ]);
  // Define this globally

  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        appBarTheme: AppBarTheme(backgroundColor: Colors.teal[500]),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.teal[50], fontSize: 20),
        ),
      ),
      title: 'My Plant',
      home: HomePage(),
    );
  }
}
