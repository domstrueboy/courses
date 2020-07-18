import 'package:flutter/cupertino.dart';

import 'dart:io';

// import '../models/Location.dart';
import '../models/Place.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace({
    String pickedTitle,
    // Location pickedLocation,
    File pickedImage,
  }) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: null,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
