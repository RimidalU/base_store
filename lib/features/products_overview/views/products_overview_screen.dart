import 'package:flutter/material.dart';

import '../data/data.dart';
import '../widgets/widgets.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: dummyProducts.length,
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 3,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, item) => ProductItem(
            id: dummyProducts[item].id,
            imageUrl: dummyProducts[item].imageUrl,
            title: dummyProducts[item].title,
          ),
        ),
      ),
    );
  }
}
