import 'package:flutter/material.dart';
import 'package:wmp/features/costume_detail/presentation/widget/costume_detail_widget.dart';
import 'package:wmp/features/costume_detail/presentation/widget/costume_description_widget.dart';
import 'package:wmp/features/costume_detail/presentation/widget/costume_image_widget.dart';
import 'package:wmp/db_helper.dart';

class CostumeDetailPage extends StatefulWidget {
  final int costumeId;

  const CostumeDetailPage({Key? key, required this.costumeId}) : super(key: key);

  @override
  _CostumeDetailPageState createState() => _CostumeDetailPageState();
}

class _CostumeDetailPageState extends State<CostumeDetailPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Map<String, dynamic>? _costume;

  @override
  void initState() {
    super.initState();
    _loadCostumeDetails();
  }

  Future<void> _loadCostumeDetails() async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'costumes',
      where: 'id = ?',
      whereArgs: [widget.costumeId],
    );

    if (result.isNotEmpty) {
      setState(() {
        _costume = result.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_costume == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final costume = _costume!;

    // Debugging: print the image URL
    print('Image URL: ${costume['imagePath']}');

    return Scaffold(
      appBar: AppBar(
        title: Text(costume['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CostumeImageWidget(imageUrl: costume['imagePath']),
            CostumeDetailWidget(
              name: costume['name'],
              category: costume['category'],
              price: costume['price'].toString(),
              size: costume['size'],
              material: costume['material'],
              color: costume['color'],
              stock: costume['stock'],
              
            ),
            CostumeDescriptionWidget(description: costume['description']),
          ],
        ),
      ),
    );
  }
}
