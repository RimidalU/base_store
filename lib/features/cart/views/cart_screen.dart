import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart' show CartProvider, OrdersProvider;
import '../../features.dart' as ci;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                      ),
                    ),
                    TextButton(
                      onPressed: cart.totalAmount <= 0
                          ? null
                          : () {
                              Provider.of<OrdersProvider>(context,
                                      listen: false)
                                  .addOrder(
                                cart.items.values.toList(),
                                cart.totalAmount,
                              );
                              cart.clear();
                            },
                      child: const Text("Order Now"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
              itemBuilder: ((context, index) => ci.CartItem(
                  id: cart.items.values.toList()[index].id,
                  productId: cart.items.keys.toList()[index],
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantity,
                  price: cart.items.values.toList()[index].price)),
              itemCount: cart.items.length,
            ))
          ],
        ),
      ),
    );
  }
}
