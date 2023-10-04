import 'package:base_store/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
  });

  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(id),
      onDismissed: (direction) => {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId),
      },
      background: Container(
        // color: const Color(0xffD0D0D0),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Icon(
          Icons.delete,
          size: 40,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      child: Card(
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
      ),
    );
  }
}
