import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/core/services/notification_service.dart';
import 'package:mock_plant_care_app/core/services/storage_service.dart';
import 'package:mock_plant_care_app/core/theme/app_theme.dart';
import 'package:mock_plant_care_app/viewmodels/plant_viewmodel.dart';
import 'package:mock_plant_care_app/viewmodels/theme_viewmodel.dart';
import 'package:mock_plant_care_app/views/pages/home_page.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final StorageService storageService = StorageService();
  final NotificationService notificationService = NotificationService();
  await storageService.init();
  await notificationService.initialize();
  await notificationService.ensurePermission();

  final PlantViewModel plantViewModel = PlantViewModel(
    storageService,
    notificationService,
  );
  final ThemeViewModel themeViewModel = ThemeViewModel(storageService);
  await plantViewModel.loadPlants();
  await themeViewModel.loadThemeMode();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PlantViewModel>.value(value: plantViewModel),
        ChangeNotifierProvider<ThemeViewModel>.value(value: themeViewModel),
      ],
      child: const AppWidget(),
    ),
  );
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (BuildContext context, ThemeViewModel themeVm, _) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: snackbarKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeVm.themeMode,
          title: 'My Plant',
          home: const HomePage(),
        );
      },
    );
  }
}
