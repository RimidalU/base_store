import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets.dart';
import '../../../providers/providers.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid(
    this.showFavoritesOnly, {
    super.key,
  });
  final bool showFavoritesOnly;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products =
        showFavoritesOnly ? productsData.favorites : productsData.items;

    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2 / 3,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, item) => ChangeNotifierProvider.value(
        value: products[item],
        child: ProductItem(key: Key(products[item].id)),
      ),
    );
  }
}
