import 'package:flutter/material.dart';

import './Product.dart';
import '../data/products.dart';

class ProductsProvider with ChangeNotifier{
  List<Product> _items = loadedProducts;

  List<Product> get items {
    return [ ..._items ];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  int get itemsCount {
    return _items == null ? 0 : _items.length;
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}