import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../providers/providers.dart' as ord;

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.order,
  });

  final ord.OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text(
            '\$${order.amount}',
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            DateFormat('dd/MM/yyy   HH:mm').format(order.createAt),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
