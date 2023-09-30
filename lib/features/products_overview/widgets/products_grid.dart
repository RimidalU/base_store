import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets.dart';
import '../../../providers/providers.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;

    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2 / 3,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, item) => ChangeNotifierProvider(
        create: (BuildContext ctx) => products[item],
        child: const ProductItem(),
      ),
    );
  }
}
