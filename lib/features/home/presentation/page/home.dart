import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmp/features/add_costume/presentation/page/add_costume_page.dart';
import 'package:wmp/features/home/presentation/widget/feature_costume_widget.dart';
import 'package:wmp/features/home/presentation/widget/search_bar_widget.dart';
import 'package:wmp/shared/theme/theme_notifier.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Konten utama
          Padding(
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
              ],
            ),
          ),

          // Tombol Ubah Tema di bawah kiri
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {
                themeNotifier.toggleTheme(); // Ubah tema
              },
              backgroundColor: Colors.grey,
              child: Icon(
                themeNotifier.isDarkTheme
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              mini: true, // Membuat tombol lebih kecil
            ),
          ),
        ],
      ),

      // Floating Action Button untuk Add Costume tetap di kanan bawah
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
