import 'package:flutter/material.dart';

import 'features/features.dart';
import 'ui/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Base Store',
      debugShowCheckedModeBanner: false,
      theme: themeData(context),
      home: const ProductsOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (context) => const ProductDetailScreen()
      },
    );
  }
}
