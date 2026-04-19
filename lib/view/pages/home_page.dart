import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/core/notifications/notification_controller.dart';
import 'package:mock_plant_care_app/view/pages/add_plant_page.dart';
import 'package:mock_plant_care_app/view/pages/plant_details_page.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';
import 'package:mock_plant_care_app/view/widgets/notfication_handler.dart';
import 'package:mock_plant_care_app/viewmodel/plant_viewmodel.dart';
import 'package:mock_plant_care_app/viewmodel/theme_viewmodel.dart';
import 'package:provider/provider.dart';

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

  void _checkNotificationPermission() {
    AwesomeNotifications().isNotificationAllowed().then((bool isAllowed) {
      if (!isAllowed && mounted) {
        NotificationPermissionHandler.showPermissionDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlantViewModel, ThemeViewModel>(
      builder:
          (
            BuildContext context,
            PlantViewModel plantVm,
            ThemeViewModel themeVm,
            _,
          ) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                title: const Text('Plant Care'),
                actions: <Widget>[
                  IconButton(
                    onPressed: themeVm.toggleTheme,
                    icon: Icon(
                      themeVm.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    ),
                  ),
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.16),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                          child: _PlantBanner(themeVm: themeVm),
                        ),
                      ),
                      if (plantVm.plants.isEmpty)
                        const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              'No plants yet. Tap + to add your first plant.',
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
                          sliver: SliverList.separated(
                            itemCount: plantVm.plants.length,
                            itemBuilder: (BuildContext context, int index) {
                              final PlantModel plant = plantVm.plants[index];
                              return _PlantCard(
                                plant: plant,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          PlantDetailsPage(plantId: plant.id),
                                    ),
                                  );
                                },
                              );
                            },
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: GlassContainer(
                borderRadius: 30,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddPlantPage()),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Plant'),
                ),
              ),
            );
          },
    );
  }
}

class _PlantBanner extends StatelessWidget {
  const _PlantBanner({required this.themeVm});

  final ThemeViewModel themeVm;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 22,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          image: const DecorationImage(
            image: AssetImage('assets/images/plant_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: <Color>[
                Colors.black.withValues(alpha: 0.45),
                Colors.black.withValues(alpha: 0.12),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Text(
                'Your Green Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                themeVm.isDarkMode
                    ? 'Dark mode is enabled'
                    : 'Light mode is enabled',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlantCard extends StatelessWidget {
  const _PlantCard({required this.plant, required this.onTap});

  final PlantModel plant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 16,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    child: const Icon(Icons.local_florist_outlined),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          plant.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(plant.species ?? 'Unknown species'),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _StatusChip(
                    label: plant.needsWaterNow ? 'Water due' : 'Water ok',
                    icon: Icons.water_drop_outlined,
                    warning: plant.needsWaterNow,
                  ),
                  _StatusChip(
                    label: plant.needsFoodNow ? 'Food due' : 'Food ok',
                    icon: Icons.grass_outlined,
                    warning: plant.needsFoodNow,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.icon,
    required this.warning,
  });

  final String label;
  final IconData icon;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return GlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: warning ? scheme.error : scheme.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: warning
                  ? scheme.error
                  : Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}
