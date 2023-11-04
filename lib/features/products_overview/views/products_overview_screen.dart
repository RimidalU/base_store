import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/cart/cart.dart';
import '../../../providers/providers.dart';
import '../../../ui/widgets/widgets.dart';
import '../widgets/widgets.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showFavoritesOnly = false;
  var _isLoading = false;

// if no need listen

//   @override
//   void initState() {
//
//     Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts();

// // if need listen

//     // Future.delayed(Duration.zero).then((_) {
//     //   Provider.of<ProductsProvider>(context).fetchAndSetProducts();
//     // });
//     super.initState();
//   }

//variant with didChangeDependencies:

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.favorites) {
                  showFavoritesOnly = true;
                }
                if (value == FilterOptions.all) {
                  showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (
              _,
              cart,
              staticChild,
            ) =>
                BadgeIcon(
              value: cart.itemCount.toString(),
              child: staticChild as Widget,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(showFavoritesOnly),
      ),
    );
  }
}
