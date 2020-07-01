import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './Product.dart';
import '../data/products.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = loadedProducts;

  List<Product> get items {
    return [..._items];
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

  Future<void> addProduct(Product product) async {
    final url =
        'https://udemy-flutter-shop-app-8f95d.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          },
        ),
      );

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );

      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void updateProduct(Product product) {
    final productIndex = _items.indexWhere((item) => item.id == product.id);
    if (productIndex < 0) return;
    _items[productIndex] = product;
    notifyListeners();
  }

  void removeProduct(String id) {
    final productIndex = _items.indexWhere((item) => item.id == id);
    if (productIndex < 0) return;
    _items.removeAt(productIndex);
    notifyListeners();
  }
}
