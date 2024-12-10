import 'package:flutter/material.dart';
import 'package:wmp/features/costume_detail/presentation/widget/costume_detail_widget.dart';
import 'package:wmp/features/costume_detail/presentation/widget/costume_description_widget.dart';
import 'package:wmp/features/costume_detail/presentation/widget/costume_image_widget.dart';
import 'package:wmp/db_helper.dart';
import 'package:wmp/features/edit_costume/presentation/page/edit_costume_page.dart';

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

  Future<void> _deleteCostume() async {
    await _dbHelper.deleteCostume(widget.costumeId);
    Navigator.pop(context); // Go back after deleting
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure to delete this costume?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteCostume();
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditPage() async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCostumePage(costumeId: widget.costumeId),
      ),
    );

    // If the costume was updated, reload details
    if (updated == true) {
      _loadCostumeDetails();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(costume['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEditPage, // Navigate to Edit Page
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _confirmDelete, // Confirm delete
          ),
        ],
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
