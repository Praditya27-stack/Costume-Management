import 'package:flutter/material.dart';

class FeatureCostumeWidget extends StatelessWidget {
  final List<Map<String, String>> costumes = [
    {"title": "Nahida", "subtitle": "Genshin Impact", "price": "Rp400.000"},
    {"title": "Nahida", "subtitle": "Genshin Impact", "price": "Rp400.000"},
    {"title": "Nahida", "subtitle": "Genshin Impact", "price": "Rp400.000"},
    {"title": "Nahida", "subtitle": "Genshin Impact", "price": "Rp400.000"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title and View All Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, // Pastikan align vertikal
              children: [
                const Text(
                  "Featured Costumes",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle "View All" action here
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
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
              itemCount: costumes.length,
              itemBuilder: (context, index) {
                final costume = costumes[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          title: costume['title']!,
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
                        // Placeholder for Image
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        // Text Content
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                costume['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                costume['subtitle']!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                costume['price']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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
  }
}

// Dummy Detail Page
class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          "Detail Page for $title",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

void main() {
  runApp( MaterialApp(
    home: Scaffold(
      body: FeatureCostumeWidget(),
    ),
  ));
}
