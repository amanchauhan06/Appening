import 'package:Appening/Core/Models/places.dart';
import 'package:Appening/Core/Services/getPlaces.dart';
import 'package:Appening/Core/ViewModels/placesViewModel.dart';
import 'package:flutter/material.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class PlacesListViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.searching;

  List<PlacesViewModel> nearbyPlaces;
  // List<PlacesViewModel> cafe;
  // List<PlacesViewModel> restaurant;
  // List<PlacesViewModel> gym;

  void allPlaces(double latitude, double longitude) async {
    List<Places> places =
        await WebService().fetchAllPlaces(latitude, longitude);
    notifyListeners();
    this.nearbyPlaces =
        places.map((place) => PlacesViewModel(place: place)).toList();

    if (this.nearbyPlaces.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }

  void placesByType(double latitude, double longitude, var type) async {
    List<Places> places =
    await WebService().fetchByFilters(latitude, longitude, type);
    notifyListeners();
    this.nearbyPlaces =
        places.map((place) => PlacesViewModel(place: place)).toList();

    if (this.nearbyPlaces.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }
}
