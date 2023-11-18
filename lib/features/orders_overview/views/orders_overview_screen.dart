import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/features.dart' as widgets;
import '../../../providers/providers.dart';
import '../../../ui/widgets/widgets.dart';

class OrdersOverviewScreen extends StatefulWidget {
  const OrdersOverviewScreen({super.key});

  static const routeName = '/orders';

  @override
  State<OrdersOverviewScreen> createState() => _OrdersOverviewScreenState();
}

class _OrdersOverviewScreenState extends State<OrdersOverviewScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<OrdersProvider>(context, listen: false).fetchAndAddOrders();
    });
    super.initState();
  }

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
