import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/ui/widgets/app_tile.dart';
import 'package:mock_plant_care_app/ui/widgets/plant_image.dart';
import 'package:mock_plant_care_app/ui/widgets/plant_stats.dart';

class PlantStatsPage extends StatelessWidget {
  const PlantStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: AppBarTitle()),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Plant Stats',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 45),
              plantImage(),
              SizedBox(height: 25),
              PlantStats(),
            ],
          ),
        ),
      ),
    );
  }
}
