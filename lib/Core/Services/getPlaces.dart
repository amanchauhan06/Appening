import 'package:Appening/Core/Models/places.dart';
import 'package:dio/dio.dart';

class WebService {
  String latitude;
  String longitude;
  final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

  Future<List<Places>> fetchAllPlaces(double latitude, double longitude) async {
    var dio = new Dio();

    final response = await dio.get(url +
        '?location=$latitude,$longitude&radius=5000&key=AIzaSyC1MUU1jDFB227nre1JmEqaxqWY7N6rOGE');
    if (response.statusCode == 200) {
      final result = response.data;

      Iterable list = result["results"];

      return list.map((place) => Places.fromJson(place)).toList();

      //  final result = response.data;

    } else {
      throw Exception("Failled to get top news");
    }
  }

  Future<List<Places>> fetchByFilters(double latitude, double longitude, var type) async {
    var dio = new Dio();

    final response = await dio.get(url +
        '?location=$latitude,$longitude&radius=5000&type=$type&key=AIzaSyC1MUU1jDFB227nre1JmEqaxqWY7N6rOGE');
    if (response.statusCode == 200) {
      final result = response.data;

      Iterable list = result["results"];

      return list.map((place) => Places.fromJson(place)).toList();

      //  final result = response.data;

    } else {
      throw Exception("Failled to get top news");
    }
  }

}
