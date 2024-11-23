import 'package:flutter/material.dart';
import 'package:wmp/features/add_costume/presentation/page/add_costume_page.dart';
import 'package:wmp/features/home/presentation/widget/feature_costume_widget.dart';
import 'package:wmp/features/home/presentation/widget/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Selamat Datang
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),

            // Search Bar
            SearchBarWidget(),
            const SizedBox(height: 16),

            // Featured Costumes  
            FeatureCostumeWidget(),

            // Tambahkan widget lainnya jika diperlukan
          ],
        ),
      ),

      // Floating Action Button untuk Add Costume
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCostumePage(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
