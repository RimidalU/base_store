import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/features.dart' as widgets;
import '../../../providers/providers.dart';
import '../../../ui/widgets/widgets.dart';

class OrdersOverviewScreen extends StatelessWidget {
  const OrdersOverviewScreen({super.key});

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (context, i) =>
              widgets.OrderItem(order: ordersData.orders[i]),
        ),
      ),
    );
  }
}
