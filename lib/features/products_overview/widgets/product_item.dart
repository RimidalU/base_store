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
    final product = Provider.of<ProductProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              size: product.isFavorite ? 30 : 20,
            ),
            onPressed: () {
              product.toggleFavoriteStatus();
            },
            color: product.isFavorite
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).indicatorColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {},
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
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
