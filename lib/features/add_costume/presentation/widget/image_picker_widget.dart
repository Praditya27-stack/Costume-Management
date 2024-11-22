import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key, required void Function() onCameraTap, required void Function() onGalleryTap, String? imagePath}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage; // Gambar yang dipilih (null jika tidak ada gambar)

  // Fungsi untuk mengambil gambar dari kamera
  Future<void> _pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Menyimpan gambar yang dipilih
      });
      print("Gambar berhasil diambil: ${pickedFile.path}");
    } else {
      _showSnackBar("Tidak ada gambar yang dipilih.");
    }
  }

  // Fungsi untuk mengambil gambar dari galeri
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Menyimpan gambar yang dipilih
      });
      print("Gambar berhasil dipilih dari galeri: ${pickedFile.path}");
    } else {
      _showSnackBar("Tidak ada gambar yang dipilih.");
    }
  }

  // Menampilkan Snackbar untuk pesan
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Menampilkan gambar yang dipilih atau teks placeholder
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _selectedImage == null
              ? Center(
                  child: Text(
                    "No Image",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        const SizedBox(width: 16), // Jarak antara gambar dan tombol
        Column(
          children: [
            ElevatedButton(
              onPressed: _pickImageFromCamera,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Icon(Icons.camera_alt, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Icon(Icons.insert_drive_file, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
