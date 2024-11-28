import 'dart:io';
import 'package:flutter/material.dart';

class CostumeImageWidget extends StatelessWidget {
  final String imageUrl;

  const CostumeImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the file exists and log for debugging
    final fileExists = File(imageUrl).existsSync();
    print('File exists: $fileExists, Path: $imageUrl');

    return GestureDetector(
      onTap: () {
        // Show full image when tapped
        _showFullImageDialog(context, imageUrl);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageUrl.isNotEmpty && fileExists
              ? Image.file(
                  File(imageUrl),
                  fit: BoxFit.cover,
                  height: 400.0,
                  width: double.infinity,
                )
              : const Center(
                  child: Icon(Icons.image, size: 50), // Placeholder for invalid paths
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Function to show full image in a dialog
  void _showFullImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            children: [
              Expanded(
                child: Image.file(
                  File(imageUrl),
                  fit: BoxFit.contain, // Ensure the whole image is shown without cropping
                  width: double.infinity,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context), // Close dialog
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Change the text color to blue (or any color you prefer)
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
