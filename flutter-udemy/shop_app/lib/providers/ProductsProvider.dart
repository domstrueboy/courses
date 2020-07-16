import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/HttpException.dart';

import './Product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  final String authToken;
  final String userId;

  ProductsProvider(this.authToken, this.userId, this._items);

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

  Future<void> fetchAndSetProducts([bool filteredByUser = false]) async {
    final filterString =
        filteredByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';
    final url =
        'https://udemy-flutter-shop-app-8f95d.firebaseio.com/products.json?auth=$authToken$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;

      final favoritesUrl =
          'https://udemy-flutter-shop-app-8f95d.firebaseio.com/favorites/$userId.json?auth=$authToken';
      final favoritesResponse = await http.get(favoritesUrl);
      final favoritesData =
          json.decode(favoritesResponse.body) as Map<String, dynamic>;

      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: favoritesData == null
                ? false
                : favoritesData[productId] ?? false,
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://udemy-flutter-shop-app-8f95d.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId': userId,
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

  Future<void> updateProduct(Product product) async {
    final productIndex = _items.indexWhere((item) => item.id == product.id);
    if (productIndex < 0) return;
    final url =
        'https://udemy-flutter-shop-app-8f95d.firebaseio.com/products/${product.id}.json?auth=$authToken';
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          },
        ),
      );
    } catch (error) {
      throw error;
    } finally {
      _items[productIndex] = product;
      notifyListeners();
    }
  }

  void removeProduct(String id) {
    final existingProductIndex = _items.indexWhere((item) => item.id == id);
    if (existingProductIndex < 0) return;
    final url =
        'https://udemy-flutter-shop-app-8f95d.firebaseio.com/products/${id}.json?auth=$authToken';
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    http.delete(url).then((response) {
      print(response.statusCode);
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete the product');
      } else {
        existingProduct = null;
      }
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
    });
  }
}
