import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Orders.dart';

import '../components/AppDrawer.dart';
import '../components/OrderCard.dart';

class OrdersPage extends StatelessWidget {
  static String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderCard(orderData.orders[i]),
      ),
    );
  }
}
