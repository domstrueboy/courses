import 'package:flutter/material.dart';

import '../components/main_drawer.dart';

class FiltersPage extends StatelessWidget {
  static final routeName = '/filters_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Filters'),
      ),
    );
  }
}
