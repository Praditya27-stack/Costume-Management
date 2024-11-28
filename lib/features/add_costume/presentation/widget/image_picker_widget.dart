import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatelessWidget {
  final Function(String) onCameraTap;
  final Function(String) onGalleryTap;
  final String? imagePath;

  const ImagePickerWidget({
    Key? key,
    required this.onCameraTap,
    required this.onGalleryTap,
    this.imagePath,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      if (source == ImageSource.camera) {
        onCameraTap(pickedFile.path);
      } else {
        onGalleryTap(pickedFile.path);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (imagePath != null && File(imagePath!).existsSync())
          Center(
            child: Image.file(
              File(imagePath!),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
        else
          Center(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 100, color: Colors.grey),
            ),
          ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(context, ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text("Camera"),
            ),
            ElevatedButton.icon(
              onPressed: () => _pickImage(context, ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: const Text("Gallery"),
            ),
          ],
        ),
      ],
    );
  }
}
