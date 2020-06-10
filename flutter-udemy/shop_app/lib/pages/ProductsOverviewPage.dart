import 'package:flutter/material.dart';

import '../components/ProductsGrid.dart';

class ProductsOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ProductsGrid(),
    );
  }
}
