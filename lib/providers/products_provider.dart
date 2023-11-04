import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../providers/providers.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductProvider> items = [];
  var uuid = const Uuid();

  List<ProductProvider> get products {
    return [...items];
  }

  List<ProductProvider> get favorites {
    return items.where((item) => item.isFavorite).toList();
  }

  ProductProvider findById(String id) {
    return items.firstWhere((item) => item.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://base-store-e0c1b-default-rtdb.europe-west1.firebasedatabase.app/products.json';

    try {
      final response = await http.get(
        Uri.parse(url),
      );

      final extractData = jsonDecode(response.body) as Map<String, dynamic>;

      final List<ProductProvider> loadedProducts = [];

      extractData.forEach((prodId, prodData) {
        loadedProducts.add(ProductProvider(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: prodData['isFavorite'],
        ));
      });
      items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(ProductProvider product) async {
    const url =
        'https://base-store-e0c1b-default-rtdb.europe-west1.firebasedatabase.app/products.json';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          },
        ),
      );

      final newProduct = ProductProvider(
        id: jsonDecode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: false,
      );
      items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void removeProduct(String productId) {
    items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  void updateProduct(
    String id,
    ProductProvider newProductBody,
  ) {
    final prodIndex = items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      items[prodIndex] = newProductBody;
      notifyListeners();
    } else {
      // print('...')
    }
  }
}
