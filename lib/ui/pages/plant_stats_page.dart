import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/widgets/widgets.dart';

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
              PlantImage(),
              SizedBox(height: 25),
              PlantStats(),
            ],
          ),
        ),
      ),
    );
  }
}
