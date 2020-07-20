import 'dart:io';
import 'package:flutter/foundation.dart';
// import '../models/Location.dart';
import '../models/Place.dart';
import '../helpers/DBHelper.dart';

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
    DBHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            location: null,
            image: File(place['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
