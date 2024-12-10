import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditableImagePickerWidget extends StatelessWidget {
  final Function(String) onImagePicked;
  final String? initialImagePath;

  const EditableImagePickerWidget({
    Key? key,
    required this.onImagePicked,
    this.initialImagePath,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      onImagePicked(pickedFile.path);
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
        // Display the selected or initial image if available
        if (initialImagePath != null && File(initialImagePath!).existsSync())
          Center(
            child: Image.file(
              File(initialImagePath!),
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
        // Buttons for image selection
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
