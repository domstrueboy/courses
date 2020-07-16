import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Orders.dart';

import '../components/AppDrawer.dart';
import '../components/OrderCard.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/orders';

  Future<void> _refreshOrders(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshOrders(context),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => _refreshOrders(context),
                child: Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) => OrderCard(orderData.orders[i]),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
