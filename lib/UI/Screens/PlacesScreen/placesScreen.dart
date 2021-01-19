import 'dart:ui';
import 'package:Appening/Core/SharedPrefrences/sharedPrefrence.dart';
import 'package:Appening/Core/ViewModels/placesListViewModel.dart';
import 'package:Appening/Core/ViewModels/placesViewModel.dart';
import 'package:Appening/UI/Screens/FilterScreen/filterScreen.dart';
import 'package:Appening/UI/Widgets/placesList.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatefulWidget {

  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  List<String> filters= [] ;
  Position _currentPosition;
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    // checkSet();
    _getCurrentLocation();

    // if(filters.length != 0){Provider.of<PlacesListViewModel>(context, listen: false)
    //     .placesByType(latitude, longitude,filters[0]);}
  }
  // void checkSet() async{
  //   List<String> filters = await getFilterList();
  //   print(filters);
  //   setState(() {
  //     this.filters = filters;
  //   });
  //   print(this.filters.length);
  // }
  Widget _buildList(PlacesListViewModel vs,) {
    switch (vs.loadingStatus) {
      case LoadingStatus.searching:
        return Center(
          child: CircularProgressIndicator(),
        );
      case LoadingStatus.completed:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: PlacesList(
            places: vs.nearbyPlaces,
          ),
        );
      case LoadingStatus.empty:
      default:
        return Center(
          child: Text("No results found"),
        );
    }
  }
  void _selectType(PlacesListViewModel vs, String type) {
    vs.placesByType(latitude, longitude, type);
  }
  @override
  Widget build(BuildContext context) {

    var vs = Provider.of<PlacesListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Appening"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () {
                print('button Pressed');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FilterScreen()));
              },
              child: Row(
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  SizedBox(width: 5,),
                  Text( this.filters  == null ? "(0)": "(${this.filters.length.toString()})")
                ]
              ),
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(padding: EdgeInsets.all(8.0), child: _buildList(vs)),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       _currentPosition == null
      //           ? CircularProgressIndicator()
      //           : Text(
      //               "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
      //       // FlatButton(
      //       //   child: Text("Get location"),
      //       //   onPressed: () {
      //       //   },
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }

  _getCurrentLocation() async{
    // final Geolocator geolocator = Geolocator();

    var pstn = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<String> fltrs = await getFilterList();
    setState(() {
      _currentPosition = pstn;
      filters = fltrs;
      latitude = _currentPosition.latitude;
      longitude = _currentPosition.longitude;
    });
    if(filters == null){Provider.of<PlacesListViewModel>(context,listen: false).allPlaces(latitude, longitude);}
    else if(filters.length == 0) { Provider.of<PlacesListViewModel>(context,listen: false).allPlaces(latitude, longitude);}
    else if(filters.length == 1 ){
        Provider.of<PlacesListViewModel>(context,listen: false).placesByType(latitude, longitude, filters[0].toLowerCase());}
    else if(filters.length == 2) {
      Provider.of<PlacesListViewModel>(context,listen: false).placesByType(latitude, longitude, filters[1].toLowerCase());}
    else if(filters.length == 3) {
      Provider.of<PlacesListViewModel>(context,listen: false).placesByType(latitude, longitude, filters[2].toLowerCase());}

  }

}
