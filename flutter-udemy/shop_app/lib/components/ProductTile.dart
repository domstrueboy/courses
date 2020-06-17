import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Product.dart';
import '../providers/Cart.dart';

import '../pages/ProductPage.dart';

class ProductTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<Product, Cart>(
      builder: (ctx, product, cart, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductPage.routeName,
                arguments: product.id,
              );
            },
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(
                product.isFavorite == null || product.isFavorite == false
                    ? Icons.favorite_border
                    : Icons.favorite,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavorite();
              },
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(
                  productId: product.id,
                  title: product.title,
                  price: product.price,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
