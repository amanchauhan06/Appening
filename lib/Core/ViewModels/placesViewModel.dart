import 'package:Appening/Core/Models/places.dart';
// import 'package:intl/intl.dart';

class PlacesViewModel {
  Places _places;

  PlacesViewModel({Places place}) : _places = place;

  String get name {
    return _places.name;
  }

  List get image {
    return _places.image;
  }

  List get type {
    return _places.type;
  }
}
