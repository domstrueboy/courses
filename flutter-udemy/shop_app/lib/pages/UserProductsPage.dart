import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ProductsProvider.dart';

import '../components/UserProductTile.dart';
import '../components/AppDrawer.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<ProductsProvider>(
          builder: (ctx, productsData, child) => ListView.builder(
            itemCount: productsData.itemsCount,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductTile(productsData.items[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
