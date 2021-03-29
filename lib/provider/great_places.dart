import 'package:flutter/foundation.dart';
import 'package:flutter_place_app/helpers/db_helper.dart';
import 'package:flutter_place_app/helpers/locatio_helper.dart';
import 'package:flutter_place_app/models/place.dart';
import 'dart:io';

class GreatePlaces with ChangeNotifier {
  List <Place> _items = [];

  List <Place> get items {
    return [..._items];
  }
  Place findById(String id){
    return _items.firstWhere((place) => place.id==id);
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlacesAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLaocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: pickedLocation.address
    );
    final newPlace = Place(title: pickedTitle,
        id: DateTime.now().toString(),
        image: pickedImage,
        location: updatedLaocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat':newPlace.location.latitude,
      'lng':newPlace.location.longitude,
      'address':newPlace.location.address,

    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map((item) =>
        Place(title: item['title'],
            id: item['id'],
            image: File(item['image']),
            location: null)).toList();
    notifyListeners();
  }
}
