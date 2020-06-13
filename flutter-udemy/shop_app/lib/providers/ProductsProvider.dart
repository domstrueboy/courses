import 'package:flutter/material.dart';

import './Product.dart';
import '../data/products.dart';

class ProductsProvider with ChangeNotifier{
  List<Product> _items = loadedProducts;

  List<Product> get items {
    return [ ..._items ];
  }

  Product findById(String id) {
    _items.firstWhere((item) => item.id == id);
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}