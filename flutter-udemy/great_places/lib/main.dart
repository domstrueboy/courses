import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './providers/Places.dart';

import './pages/PlacesListPage.dart';
import './pages/AddPlacePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Great places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListPage(),
        routes: {
          AddPlacePage.routeName: (_) => AddPlacePage(),
        },
      ),
    );
  }
}
