import 'package:flutter/material.dart';
import 'dart:io';
import 'package:wmp/db_helper.dart';
import 'package:wmp/features/edit_costume/presentation/widget/image_picker_widget.dart';
import 'package:wmp/features/edit_costume/presentation/widget/edit_costume_form_widget.dart';

class EditCostumePage extends StatefulWidget {
  final int costumeId;

  const EditCostumePage({Key? key, required this.costumeId}) : super(key: key);

  @override
  _EditCostumePageState createState() => _EditCostumePageState();
}

class _EditCostumePageState extends State<EditCostumePage> {
  File? selectedImage;
  Map<String, dynamic>? costumeData;
  bool isLoading = true;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadCostumeDetails();
  }

  Future<void> _loadCostumeDetails() async {
    final data = await _dbHelper.getCostumeById(widget.costumeId);
    if (data != null) {
      setState(() {
        costumeData = data;
        selectedImage = data['imagePath'] != null ? File(data['imagePath']) : null;
        isLoading = false;
      });
    }
  }

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

  void _updateCostume(Map<String, dynamic> updatedData) async {
    if (selectedImage != null) {
      updatedData['imagePath'] = selectedImage!.path;
    }

    await _dbHelper.updateCostume(widget.costumeId, updatedData);
    Navigator.pop(context, true); // Return true to indicate an update
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Costume",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditableImagePickerWidget(
                onImagePicked: (path) {
                  setState(() {
                    selectedImage = File(path);
                  });
                },
                initialImagePath: selectedImage?.path,
              ),
              const SizedBox(height: 24),
              EditCostumeFormWidget(
                imagePath: selectedImage?.path,
                initialData: costumeData, // Pass initial data to pre-fill the form
                onSubmit: _updateCostume, // Callback for form submission
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  