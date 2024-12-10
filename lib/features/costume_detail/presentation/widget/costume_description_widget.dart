import 'package:flutter/material.dart';

class CostumeDescriptionWidget extends StatelessWidget {
  final String description;

  const CostumeDescriptionWidget({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check the current theme (dark or light) and set the color accordingly
    Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white // White color for dark theme
        : Colors.black54; // Default color for light theme

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        description,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
