import 'package:flutter/material.dart';

Widget plantImage() {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: const Image(
      fit: BoxFit.fitHeight,
      image: AssetImage('assets/images/plant_image.png'),
      height: 450,
    ),
  );
}
