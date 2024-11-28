import 'package:flutter/material.dart';
import 'dart:io';
import 'package:wmp/features/add_costume/presentation/widget/add_costume_form_widget.dart';
import 'package:wmp/features/add_costume/presentation/widget/image_picker_widget.dart';

class AddCostumePage extends StatefulWidget {
  @override
  _AddCostumePageState createState() => _AddCostumePageState();
}

class _AddCostumePageState extends State<AddCostumePage> {
  File? selectedImage;

  void pickImageFromGallery(String path) {
    setState(() {
      selectedImage = File(path);
    });
  }

  void pickImageFromCamera(String path) {
    setState(() {
      selectedImage = File(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Costume",
          style: TextStyle(
            color: Colors.white, // Text color
          ),
        ),
        backgroundColor: Colors.blue, // AppBar background color
        iconTheme: const IconThemeData(
          color: Colors.white, // Back icon color
        ),
      ),
      body: SingleChildScrollView( // Make the whole body scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagePickerWidget(
                onCameraTap: pickImageFromCamera,
                onGalleryTap: pickImageFromGallery,
                imagePath: selectedImage?.path,
              ),
              const SizedBox(height: 24),
              AddCostumeFormWidget(imagePath: selectedImage?.path),
            ],
          ),
        ),
      ),
    );
  }
}
