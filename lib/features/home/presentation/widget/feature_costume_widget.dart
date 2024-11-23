import 'package:flutter/material.dart';
import 'package:wmp/features/costume_detail/presentation/page/costume_detail_page.dart';

class FeatureCostumeWidget extends StatelessWidget {
  final List<Map<String, String>> costumes = [
    {
      "title": "Nahida",
      "subtitle": "Genshin Impact",
      "price": "Rp400.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "title": "Raiden Shogun",
      "subtitle": "Genshin Impact",
      "price": "Rp450.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "title": "Kamisato Ayaka",
      "subtitle": "Genshin Impact",
      "price": "Rp430.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "title": "Venti",
      "subtitle": "Genshin Impact",
      "price": "Rp420.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    // Navigate to costume_detail_page.dart
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CostumeDetailPage(
                          title: costume['title']!,
                          subtitle: costume['subtitle']!,
                          price: costume['price']!,
                          imageUrl: costume['imageUrl']!,
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
                            child: Center(
                              child: Image.network(
                                costume['imageUrl']!,
                                fit: BoxFit.cover,
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
