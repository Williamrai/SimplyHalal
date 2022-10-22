import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:simply_halal/model/business_details.dart';

class MapScreen extends StatefulWidget {
  // This is under BusinessDetails file
  // you will receive this lat and long from the business details

  // right now you will receive lat and long as 0.0
  // to update it goTo restaurantDetailsWidget() of RestaurantDetailsScreen
  final Coordinates coordinates;

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
          options: MapOptions(
              center: LatLng(27.125002, 78.0421170902921), minZoom: 17.0),
          children: [
            TileLayer(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/marz-hunter/cl9c7sag3000114mvj0scrwfb/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFyei1odW50ZXIiLCJhIjoiY2t0N2lobXdhMHNxcDJ2cDR4YWV4YWdzaSJ9.hYkxPJNMNyX1PgTDS0sNBQ",
                additionalOptions: const {
                  'accessToken':
                      'pk.eyJ1IjoibWFyei1odW50ZXIiLCJhIjoiY2t0N2lobXdhMHNxcDJ2cDR4YWV4YWdzaSJ9.hYkxPJNMNyX1PgTDS0sNBQ',
                  'id': 'mapbox.mapbox-streets-v8'
                }),
          ]),
    );
  }
}
