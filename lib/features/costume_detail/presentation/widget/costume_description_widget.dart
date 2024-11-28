import 'package:flutter/material.dart';

class CostumeDescriptionWidget extends StatelessWidget {
  final String description;

  const CostumeDescriptionWidget({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
