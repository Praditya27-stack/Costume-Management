import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:wmp/features/add_costume/presentation/widget/add_costume_form_widget.dart';
import 'package:wmp/features/add_costume/presentation/widget/image_picker_widget.dart';

class AddCostumePage extends StatefulWidget {
  @override
  _AddCostumePageState createState() => _AddCostumePageState();
}

class _AddCostumePageState extends State<AddCostumePage> {
  File? selectedImage;

  void pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Costume",
          style: TextStyle(
            color: Colors.white, // Warna teks
          ),
        ),
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
        iconTheme: const IconThemeData(
          color: Colors.white, // Warna ikon back
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ImagePickerWidget(
              onCameraTap: pickImageFromCamera,
              onGalleryTap: pickImageFromGallery,
              imagePath: selectedImage?.path,
            ),
            const SizedBox(height: 24),
            AddCostumeFormWidget(),
          ],
        ),
      ),
    );
  }
}
