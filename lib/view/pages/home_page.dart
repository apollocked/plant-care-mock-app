import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';
import 'package:mock_plant_care_app/core/notifications/notification_controller.dart';
import 'package:mock_plant_care_app/view/pages/add_plant_page.dart';
import 'package:mock_plant_care_app/view/pages/plant_details_page.dart';
import 'package:mock_plant_care_app/view/widgets/home/empty_state.dart';
import 'package:mock_plant_care_app/view/widgets/home/hero_banner.dart';
import 'package:mock_plant_care_app/view/widgets/home/home_header.dart';
import 'package:mock_plant_care_app/view/widgets/home/plant_card.dart';
import 'package:mock_plant_care_app/view/widgets/home/stats_row.dart';
import 'package:mock_plant_care_app/view/widgets/home/urgent_banner.dart';
import 'package:mock_plant_care_app/view/widgets/notfication_handler.dart';
import 'package:mock_plant_care_app/viewmodel/plant_viewmodel.dart';
import 'package:mock_plant_care_app/viewmodel/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabAnim;

  @override
  void initState() {
    super.initState();
    _fabAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeNotifications().isNotificationAllowed().then((bool allowed) {
        if (!allowed && mounted) {
          NotificationPermissionHandler.showPermissionDialog(context);
        }
      });
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
    _fabAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PlantViewModel plantVm = context.watch<PlantViewModel>();
    final ThemeViewModel themeVm = context.watch<ThemeViewModel>();
    final bool isDark = themeVm.isDarkMode;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final int urgent = plantVm.plants
        .where((p) => p.needsWaterNow || p.needsFoodNow)
        .length;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(
        isDark: isDark,
        onToggleTheme: themeVm.toggleTheme,
        onSurface: scheme.onSurface,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const <double>[0.0, 0.45, 1.0],
            colors: <Color>[
              scheme.primary.withValues(alpha: isDark ? 0.25 : 0.18),
              scheme.primary.withValues(alpha: isDark ? 0.08 : 0.05),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: HeroBanner(urgentCount: urgent),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                  child: StatsRow(plantVm: plantVm),
                ),
              ),
              if (urgent > 0)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                    child: UrgentBanner(urgentCount: urgent),
                  ),
                ),
              SliverToBoxAdapter(
                child: SectionHeader(
                  count: plantVm.plants.length,
                  onSurface: scheme.onSurface,
                  scheme: scheme,
                ),
              ),
              if (plantVm.plants.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyPlantState(),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  sliver: SliverList.separated(
                    itemCount: plantVm.plants.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      final PlantModel p = plantVm.plants[i];
                      return PlantCard(
                        plant: p,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlantDetailsPage(plantId: p.id),
                          ),
                        ),
                        onWaterTap: () => context
                            .read<PlantViewModel>()
                            .markPlantWatered(p.id),
                        onFeedTap: () =>
                            context.read<PlantViewModel>().markPlantFed(p.id),
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: CurvedAnimation(parent: _fabAnim, curve: Curves.elasticOut),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPlantPage()),
          ),
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: <Color>[
                  scheme.primary,
                  Color.lerp(scheme.primary, Colors.teal, 0.5)!,
                ],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add_rounded, color: Colors.white, size: 22),
                SizedBox(width: 8),
                Text(
                  'Add Plant',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
