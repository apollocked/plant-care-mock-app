import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/ui/widgets/plant_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Plant"),
        backgroundColor: ThemeData().primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [plantImage()],
        ),
      ),
    );
  }
}
