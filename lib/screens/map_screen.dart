import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:simply_halal/model/business.dart';
import 'package:simply_halal/model/business_details.dart' as cord;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math';

class MapScreen extends StatefulWidget {
  // This is under BusinessDetails file
  // you will receive this lat and long from the business details

  // right now you will receive lat and long as 0.0
  // to update it goTo restaurantDetailsWidget() of RestaurantDetailsScreen
  final cord.Coordinates coordinates;

  MapScreen({super.key, required this.coordinates});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    // this will give you the latitude of the business details
    // widget.coordinates.latitude

    return Scaffold(
      body: FlutterMap(
          options: MapOptions(center: LatLng(40.7678, -73.9645), zoom: 16.0),
          children: [
            TileLayer(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/marz-hunter/cl9c7sag3000114mvj0scrwfb/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFyei1odW50ZXIiLCJhIjoiY2t0N2lobXdhMHNxcDJ2cDR4YWV4YWdzaSJ9.hYkxPJNMNyX1PgTDS0sNBQ",
                additionalOptions: const {
                  'accessToken':
                      'pk.eyJ1IjoibWFyei1odW50ZXIiLCJhIjoiY2t0N2lobXdhMHNxcDJ2cDR4YWV4YWdzaSJ9.hYkxPJNMNyX1PgTDS0sNBQ',
                  'id': 'mapbox.mapbox-streets-v8'
                }),
            MarkerLayer(
              markers: [
                Marker(
                  width: 50.0,
                  height: 50.0,
                  point: LatLng(40.7618, -73.97928),
                  builder: (ctx) => Container(
                    child: Icon(Icons.location_pin, color: Colors.red),
                  ),
                ),
                Marker(
                  width: 50.0,
                  height: 50.0,
                  point: LatLng(40.7678, -73.9645),
                  builder: (ctx) => Container(
                    child: Icon(Icons.my_location, color: Colors.black),
                  ),
                )
              ],
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: points,
                  color: Colors.black,
                  strokeWidth: 3,
                ),
              ],
            )
          ]),
    );
  }

  List<LatLng> points = [LatLng(40.7678, -73.9645), LatLng(40.7618, -73.97928)];
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location services are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permisssions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<cord.Coordinates> getCurrentUserLocation() async {
    Position position = await _determinePosition();
    return cord.Coordinates(
        latitude: position.latitude, longitude: position.longitude);
  }

  double getDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
