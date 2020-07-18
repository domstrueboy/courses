import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Product.dart';
import '../providers/Cart.dart';
import '../providers/Auth.dart';

import '../pages/ProductPage.dart';

class ProductTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer3<Product, Cart, Auth>(
      builder: (ctx, product, cart, auth, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder:
                    AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
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
                product.toggleFavorite(
                  auth.token,
                  auth.userId,
                );
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
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added item to cart',
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
