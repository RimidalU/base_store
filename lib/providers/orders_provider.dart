import 'dart:convert';

import 'package:base_store/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  late List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndAddOrders() async {
    const url =
        'https://base-store-e0c1b-default-rtdb.europe-west1.firebasedatabase.app/orders.json';

    final response = await http.get(Uri.parse(url));

    final List<OrderItem> loadedOrders = [];

    final extractedItems = jsonDecode(response.body) as Map<String, dynamic>;

    if (extractedItems.isEmpty) {
      return;
    }

    extractedItems.forEach(
      (orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            createAt: DateTime.parse(
              orderData['createAt'],
            ),
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price']))
                .toList(),
          ),
        );
      },
    );
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(
    List<CartItem> cartProducts,
    double total,
  ) async {
    const url =
        'https://base-store-e0c1b-default-rtdb.europe-west1.firebasedatabase.app/orders.json';

    final timeStamp = DateTime.now();

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'amount': total,
            'products': cartProducts
                .map(
                  (item) => {
                    'id': item.id,
                    'title': item.title,
                    'quantity': item.quantity,
                    'price': item.price,
                  },
                )
                .toList(),
            'createAt': timeStamp.toIso8601String(),
          },
        ),
      );

      _orders.insert(
        0,
        OrderItem(
          id: jsonDecode(response.body)['name'],
          amount: total,
          products: cartProducts,
          createAt: timeStamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw HttpException('Order not created');
    }
  }
}
