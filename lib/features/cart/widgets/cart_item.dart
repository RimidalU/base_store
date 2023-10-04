import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });

  final String id;
  final String title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$$price'),
              ),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          subtitle: Text('Total: \$${(price * quantity)}'),
          trailing: Text(
            '$quantity x',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
