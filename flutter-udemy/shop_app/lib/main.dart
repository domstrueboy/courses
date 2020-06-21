import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/ProductsProvider.dart';
import './providers/Cart.dart';
import './providers/Orders.dart';

import './pages/ProductsOverviewPage.dart';
import './pages/ProductPage.dart';
import './pages/CartPage.dart';
import './pages/OrdersPage.dart';
import './pages/UserProductsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverviewPage(),
        routes: {
          ProductPage.routeName: (ctx) => ProductPage(),
          CartPage.routeName: (ctx) => CartPage(),
          OrdersPage.routeName: (ctx) => OrdersPage(),
          UserProductsPage.routeName: (ctx) => UserProductsPage(),
        },
      ),
    );
  }
}
