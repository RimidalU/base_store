import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './features/features.dart';
import './providers/providers.dart';
import './ui/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => OrdersProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Base Store',
        debugShowCheckedModeBanner: false,
        theme: themeData(context),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersOverviewScreen.routeName: (context) =>
              const OrdersOverviewScreen(),
          OrderDetailScreen.routeName: (context) => const OrderDetailScreen(),
        },
      ),
    );
  }
}
