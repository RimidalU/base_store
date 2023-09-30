import 'package:base_store/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/features.dart';
import 'ui/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProductsProvider(),
      child: MaterialApp(
        title: 'Base Store',
        debugShowCheckedModeBanner: false,
        theme: themeData(context),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen()
        },
      ),
    );
  }
}
