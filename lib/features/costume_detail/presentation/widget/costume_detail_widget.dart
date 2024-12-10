import 'package:flutter/material.dart';

class CostumeDetailWidget extends StatelessWidget {
  final String name;
  final String category;
  final String price;
  final String size;
  final String material;
  final String color;
  final int stock;

  const CostumeDetailWidget({
    Key? key,
    required this.name,
    required this.category,
    required this.price,
    required this.size,
    required this.material,
    required this.color,
    required this.stock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\Rp. $price',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text('Size: $size'),
          Text('Material: $material'),
          Text('Color: $color'),
          Text('Stock: $stock items left'),
        ],
      ),
    );
  }
}
