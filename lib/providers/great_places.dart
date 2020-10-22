import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_places/helper/api_helper.dart';
import 'package:great_places/helper/location_helper.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id)
  {
    return _items.firstWhere((element) => element.id == id);
  }

  void addPlace(String title, File image, double latitude, double longitude) async {
    var id = DateTime.now().toString(); 
    var address = await LocationHelper.getPlaceAddress(latitude, longitude);
    final newPlace = Place(
        id: id,
        image: image,
        title: title,
        location: new PlaceLocation(
          latitude: latitude, longitude: longitude, id: id, address: address));

    _items.add(newPlace);

    notifyListeners();

   await ApiHelper.postData(ApiHelper.API + "locations", {
      "id":id,
      "longitude":longitude,
      "latitude":latitude,
      "address":address
    });
  }
}
