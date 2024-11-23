import 'package:flutter/material.dart';
import 'package:wmp/features/costume_detail/presentation/widget/costume_detail_widget.dart';

class CostumeDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imageUrl;

  const CostumeDetailPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Tambahkan logika untuk ikon edit
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Edit costume detail!")),
              );
            },
          ),
        ],
      ),
      body: CostumeDetailWidget(
        title: title,
        subtitle: subtitle,
        price: price,
        imageUrl: imageUrl,
      ),
    );
  }
}
