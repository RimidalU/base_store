import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/features.dart';
import '../../../providers/providers.dart';
import '../../../ui/widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsOverviewScreen extends StatelessWidget {
  const UserProductsOverviewScreen({super.key});

  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).fetchAndSetProducts();
  }

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
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
                itemBuilder: (context, item) => Column(
                      children: [
                        UserProductItem(
                          imageUrl: productsData.items[item].imageUrl,
                          title: productsData.items[item].title,
                          id: productsData.items[item].id,
                        ),
                        const Divider(),
                      ],
                    ),
                itemCount: productsData.items.length),
          ),
        ));
  }
}
