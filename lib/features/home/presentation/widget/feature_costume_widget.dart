import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wmp/db_helper.dart';
import 'package:wmp/features/costume_detail/presentation/page/costume_detail_page.dart';

class FeatureCostumeWidget extends StatefulWidget {
  final String searchQuery;

  const FeatureCostumeWidget({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _FeatureCostumeWidgetState createState() => _FeatureCostumeWidgetState();
}

class _FeatureCostumeWidgetState extends State<FeatureCostumeWidget> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> _fetchCostumes() async {
    final db = await _dbHelper.database;
    final result = await db.query('costumes');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchCostumes(), // Fetch all costumes from the database
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No costumes available'));
        }

        final costumes = snapshot.data!;
        
        // Filter costumes based on the search query
        final filteredCostumes = costumes.where((costume) {
          final name = costume['name'] as String;
          return name.toLowerCase().contains(widget.searchQuery.toLowerCase());
        }).toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Featured Costumes",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Costume Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items per row
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75, // Aspect ratio for the card
                  ),
                  itemCount: filteredCostumes.length,
                  itemBuilder: (context, index) {
                    final costume = filteredCostumes[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to costume_detail_page.dart with the costume ID
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CostumeDetailPage(
                              costumeId: costume['id'], // Pass the costume ID
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Placeholder
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: costume['imagePath'] != null && costume['imagePath']!.isNotEmpty
                                    ? Image.file(
                                        File(costume['imagePath']), // Use File to load the local image
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.error); // Display an error icon if image fails to load
                                        },
                                      )
                                    : const Icon(Icons.image, size: 50), // Fallback icon if no image is available
                              ),
                            ),
                            // Text Content
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    costume['name'] ?? 'No Name',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    costume['category'] ?? 'No Category',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp. ${costume['price']?.toString() ?? '0'}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
