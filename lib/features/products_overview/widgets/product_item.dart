import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
            color: Theme.of(context).indicatorColor,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {},
            color: Theme.of(context).indicatorColor,
          ),
          backgroundColor: const Color(0xff121418).withOpacity(.4),
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
