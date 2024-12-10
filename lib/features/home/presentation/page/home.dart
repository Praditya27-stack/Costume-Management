import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmp/features/add_costume/presentation/page/add_costume_page.dart';
import 'package:wmp/features/home/presentation/widget/feature_costume_widget.dart';
import 'package:wmp/features/home/presentation/widget/search_bar_widget.dart';
import 'package:wmp/shared/theme/theme_notifier.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Header
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
                SearchBarWidget(
                  onSearchChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
                const SizedBox(height: 32),
              
                // Featured Costumes
                FeatureCostumeWidget(searchQuery: _searchQuery),
              ],
            ),
          ),

          // Theme toggle button at bottom-left
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {
                themeNotifier.toggleTheme(); // Toggle theme
              },
              backgroundColor: Colors.grey,
              child: Icon(
                themeNotifier.isDarkTheme
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              mini: true, // Smaller button
            ),
          ),
        ],
      ),

      // Floating action button to add a costume
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
