import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';

class UserProductsOverviewScreen extends StatelessWidget {
  const UserProductsOverviewScreen({super.key});

  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your products',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemBuilder: (context, item) {
                return Text(productsData.items[item].title);
              },
              itemCount: productsData.items.length),
        ));
  }
}
