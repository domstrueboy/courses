import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/Auth.dart';
import './providers/ProductsProvider.dart';
import './providers/Cart.dart';
import './providers/Orders.dart';

import './pages/ProductsOverviewPage.dart';
import './pages/ProductPage.dart';
import './pages/CartPage.dart';
import './pages/OrdersPage.dart';
import './pages/UserProductsPage.dart';
import './pages/AddEditProductPage.dart';
import './pages/AuthPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (ctx) => ProductsProvider('token', []),
          update: (ctx, auth, previousProducts) => ProductsProvider(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('token', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth ? ProductsOverviewPage() : AuthPage(),
          routes: {
            ProductsOverviewPage.routeName: (ctx) => ProductsOverviewPage(),
            ProductPage.routeName: (ctx) => ProductPage(),
            CartPage.routeName: (ctx) => CartPage(),
            OrdersPage.routeName: (ctx) => OrdersPage(),
            UserProductsPage.routeName: (ctx) => UserProductsPage(),
            AddEditProductPage.routeName: (ctx) => AddEditProductPage(),
          },
        ),
      ),
    );
  }
}
