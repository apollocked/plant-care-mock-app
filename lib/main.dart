import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/ui/pages/home_page.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.teal),
      title: 'My Plant',
      home: HomePage(),
    );
  }
}
