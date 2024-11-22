import 'package:flutter/material.dart';
import 'package:wmp/features/add_costume/presentation/page/add_costume_page.dart';
import 'package:wmp/features/home/presentation/widget/feature_costume_widget.dart';
import 'package:wmp/features/home/presentation/widget/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16), // Space between header and search bar

            // Search Bar
            SearchInputField(),
            FeatureCostumeWidget(),

            // Add more widgets below if needed
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCostumePage(), // Navigasi ke AddProduct
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add), // Ikon tombol
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Posisi kanan bawah
    );
  }
}
