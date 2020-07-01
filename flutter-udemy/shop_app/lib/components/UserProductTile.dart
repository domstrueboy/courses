import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/AddEditProductPage.dart';

import '../providers/ProductsProvider.dart';
import '../providers/Product.dart';

class UserProductTile extends StatelessWidget {
  final Product product;

  UserProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AddEditProductPage.routeName,
                  arguments: product.id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<ProductsProvider>(context, listen: false)
                    .removeProduct(product.id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
