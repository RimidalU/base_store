import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './cart_provider.dart';

var uuid = const Uuid();

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime createAt;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.createAt,
  });
}

class OrdersProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(
    List<CartItem> cartProducts,
    double total,
  ) {
    _orders.insert(
      0,
      OrderItem(
        id: uuid.v4(),
        amount: total,
        products: cartProducts,
        createAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
