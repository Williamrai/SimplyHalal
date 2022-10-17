import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  MapScreenState createState() => new MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
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
