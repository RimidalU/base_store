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
  late Future _ordersFuture;

  Future _receiveOrdersFuture() {
    return Provider.of<OrdersProvider>(context, listen: false)
        .fetchAndAddOrders();
  }

  @override
  void initState() {
    _ordersFuture = _receiveOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.hasError) {
              return const Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<OrdersProvider>(
                builder: (context, ordersData, child) => ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (context, i) =>
                      widgets.OrderItem(order: ordersData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
