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
                urlTemplate: "Generated Template",
                additionalOptions: const {
                  'accessToken': 'Generated Acess token',
                  'id': 'mapbox.mapbox-streets-v7'
                }),
          ]),
    );
  }
}
