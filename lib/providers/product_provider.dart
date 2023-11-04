import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class ProductProvider with ChangeNotifier {
  late final String id;
  late final String title;
  late final String description;
  late final double price;
  late final String imageUrl;
  late bool isFavorite;

  ProductProvider({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() async {
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();

    final url =
        'https://base-store-e0c1b-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json';
    try {
      final response = await http.patch(
        Uri.parse(url),
        body: jsonEncode(
          {'isFavorite': isFavorite},
        ),
      );

      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();

      throw HttpException('Could not change favorites');
    }
  }
}
