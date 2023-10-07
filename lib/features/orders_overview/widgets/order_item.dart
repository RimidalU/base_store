import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../providers/providers.dart' as ord;

class OrderItem extends StatefulWidget {
  const OrderItem({
    super.key,
    required this.order,
  });

  final ord.OrderItem order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var expended = false;

  double getHeight() {
    return widget.order.products.length * 20 + 10;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.order.amount}',
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyy   HH:mm').format(widget.order.createAt),
            ),
            trailing: IconButton(
              icon: Icon(expended ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  expended = !expended;
                });
              },
            ),
          ),
          if (expended)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: min(getHeight(), 180),
              child: ListView.builder(
                itemBuilder: (
                  context,
                  item,
                ) =>
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.order.products[item].title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                        '${widget.order.products[item].quantity} x \$${widget.order.products[item].price}')
                  ],
                ),
                itemCount: widget.order.products.length,
              ),
            )
        ],
      ),
    );
  }
}
