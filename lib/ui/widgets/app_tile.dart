import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(FontAwesomeIcons.pagelines, color: Colors.teal[50]),
        const SizedBox(width: 10),
        const Text('My Plant', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
