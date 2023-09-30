import 'package:base_store/providers/providers.dart';
import 'package:flutter/material.dart';

import './data/fake_products.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductProvider> items = dummyProducts;

  List<ProductProvider> get products {
    return [...items];
  }

  List<ProductProvider> get favorites {
    return items.where((item) => item.isFavorite).toList();
  }

  ProductProvider findById(String id) {
    return items.firstWhere((item) => item.id == id);
  }

  void addProduct() {
    //TODO: items.add(product);
    notifyListeners();
  }
}
