import 'package:flutter/material.dart';

class CategoryMealsPage extends StatelessWidget {
  static final routeName = '/category_meals_page';
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final title = routeArgs['title'];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Meals of the category!'),
      ),
    );
  }
}
