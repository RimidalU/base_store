import 'package:flutter/material.dart';

import './data/fake_products.dart';
import './models/models.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> items = dummyProducts;

  List<Product> get products {
    return [...items];
  }

  void addProduct() {
    //TODO: items.add(product);
    notifyListeners();
  }
}
