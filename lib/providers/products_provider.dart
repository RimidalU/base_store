import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './data/fake_products.dart';
import '../providers/providers.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductProvider> items = dummyProducts;
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

  void addProduct(ProductProvider product) {
    final newProduct = ProductProvider(
      id: uuid.v4(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: false,
    );
    items.insert(0, newProduct);
    notifyListeners();
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
