import 'package:flutter/material.dart';

class AddEditProductPage extends StatefulWidget {
  static const routeName = '/add-edit-product';
  @override
  _AddEditProductPageState createState() => _AddEditProductPageState();
}

class _AddEditProductPageState extends State<AddEditProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit product'),
      ),
      body: Text('Blabla'),
    );
  }
}
