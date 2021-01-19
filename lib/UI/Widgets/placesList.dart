import 'package:Appening/Core/ViewModels/placesViewModel.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  final List<PlacesViewModel> places;

  PlacesList({this.places});

  @override
  Widget build(BuildContext context) {
    String image;
    return ListView.builder(
        itemCount: this.places.length,
        itemBuilder: (BuildContext _, int index) {
          final place = this.places[index];
          if (place.image == null) {
            image = null;
          } else {
            image = place.image[0]["photo_reference"];
          }
          return image == null
              ? SizedBox()
              : Card(
                  child: Column(
                    children: [
                      Image.network(
                        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=4000&photoreference=$image&sensor=false&key=AIzaSyC1MUU1jDFB227nre1JmEqaxqWY7N6rOGE',
                        height: 200,
                        width: double.infinity,
                      ),
                      Divider(height: 5, color: Colors.grey),
                      Text(
                        place.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '${place.type[0]},  ${place.type[1]},',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                );
        });
  }
}
