import 'package:flutter/material.dart';

import 'features/features.dart';

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
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff121418),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: const Color(0xff202329),
              titleTextStyle: const TextStyle(
                color: Color(0xffD0D0D0),
              ),
            ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: const Color(0xffD0D0D0),
              displayColor: const Color(0xffD0D0D0),
            ),
        useMaterial3: true,
      ),
      home: const ProductsOverviewScreen(),
    );
  }
}
