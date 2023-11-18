import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/features.dart';
import '../../../providers/providers.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: Consumer<ProductProvider>(
            builder:
                (BuildContext context, ProductProvider value, Widget? child) =>
                    IconButton(
              icon: Icon(
                Icons.favorite,
                size: product.isFavorite ? 30 : 20,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              color: product.isFavorite
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).disabledColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Product added to cart!',
                  ),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleProduct(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).indicatorColor,
          ),
          backgroundColor: const Color(0xff121418).withOpacity(.4),
        ),
        child: GestureDetector(
          onTap: () => {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            ),
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
