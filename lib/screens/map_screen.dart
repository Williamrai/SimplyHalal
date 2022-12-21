import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:simply_halal/model/business.dart';
import 'package:simply_halal/model/business_details.dart' as cord;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:simply_halal/utils.dart';

//import 'package:turf/turf.dart';
import 'dart:math';

import 'package:simply_halal/widgets/big_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/small_text.dart';

class MapScreen extends StatefulWidget {
  // This is under BusinessDetails file
  // you will receive this lat and long from the business details

  // right now you will receive lat and long as 0.0
  // to update it goTo restaurantDetailsWidget() of RestaurantDetailsScreen
  // this will be provide the coordinates of the restaurant
  final cord.Coordinates coordinates;
  final double distance;

  const MapScreen(
      {super.key, required this.coordinates, required this.distance});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    // this will give you the latitude of the business details
    // widget.coordinates.latitude
    return Scaffold(
        body: FutureBuilder(
            future: getCurrentUserLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // this gives the device current location

                final curLocation = snapshot.data as cord.Coordinates;
                // restaurants coordinates = lat: 40.7618, long: -73.97928
                // user coordinates = curLocation.latitude!, curLocation.longitude!
                double miles = getDistance(
                    widget.coordinates.latitude,
                    widget.coordinates.longitude,
                    curLocation.latitude!,
                    curLocation.longitude!);
                String distance =
                    "${Utils.getDistanceInMiles(widget.distance).toStringAsFixed(2)} miles";
                String url =
                    "https://www.google.com/maps/dir/?api=1&origin=${curLocation.latitude},${curLocation.longitude}&destination=${widget.coordinates.latitude},${widget.coordinates.longitude}";
                double zoomMin = 10.54;
                if (miles < 3) {
                  zoomMin = 14;
                }

                return Column(
                  children: [
                    AppBar(
                        backgroundColor: Colors.white,
                        title: const Text("Direction")),
                    SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlutterMap(
                            options: MapOptions(
                              /* center: LatLng(curLocation.latitude!,
                                  curLocation.longitude!),*/
                              minZoom: zoomMin,
                              bounds: LatLngBounds(
                                LatLng(curLocation.latitude!,
                                    curLocation.longitude!),
                                LatLng(widget.coordinates.latitude!,
                                    widget.coordinates.longitude!),
                              ),
                              boundsOptions: FitBoundsOptions(
                                  padding: EdgeInsets.all(25.0)),
                            ),
                            children: [
                              TileLayer(
                                  urlTemplate:
                                      "https://api.mapbox.com/styles/v1/marz-hunter/cl9c7sag3000114mvj0scrwfb/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFyei1odW50ZXIiLCJhIjoiY2t0N2lobXdhMHNxcDJ2cDR4YWV4YWdzaSJ9.hYkxPJNMNyX1PgTDS0sNBQ",
                                  additionalOptions: const {
                                    'accessToken':
                                        'pk.eyJ1IjoibWFyei1odW50ZXIiLCJhIjoiY2t0N2lobXdhMHNxcDJ2cDR4YWV4YWdzaSJ9.hYkxPJNMNyX1PgTDS0sNBQ',
                                    'id': 'mapbox.mapbox-streets-v8'
                                  }),
                              // halal restaurant location
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    // Restaurant Marker
                                    width: 50.0,
                                    height: 50.0,
                                    point: LatLng(widget.coordinates.latitude!,
                                        widget.coordinates.longitude!),
                                    builder: (ctx) => const Icon(
                                        Icons.location_pin,
                                        color: Colors.red),
                                  ),

                                  // your location
                                  Marker(
                                    // Device Marker
                                    width: 50.0,
                                    height: 50.0,
                                    point: LatLng(curLocation.latitude!,
                                        curLocation.longitude!),
                                    builder: (ctx) => const Icon(
                                        Icons.my_location,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              PolylineLayer(
                                polylines: [
                                  Polyline(
                                    points: [
                                      LatLng(curLocation.latitude!,
                                          curLocation.longitude!),
                                      LatLng(widget.coordinates.latitude!,
                                          widget.coordinates.longitude!)
                                    ],
                                    color: Colors.black,
                                    strokeWidth: 3,
                                    isDotted: true,
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),

                    // distance
                    SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SmallText(
                              text: "Distance: $distance",
                              align: TextAlign.center,
                              size: 18,
                            ))),

                    // Show navigation in
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: BigText(
                            text: "Open Navigation in",
                            size: 20,
                            align: TextAlign.left,
                          ),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            launchUrlString(url);
                          },
                          child: BigText(
                            text: "Google Maps",
                            align: TextAlign.center,
                            size: 18,
                          )),
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

   void _launchGoogleMap(String googleMapsUrl) async {
    if (await canLaunchUrlString(googleMapsUrl)) {
      await launchUrlString(googleMapsUrl);
    } else {
      throw ("Could not open the map");
    }
  }

/*
  static Future<void> _launchGoogleMap(String googleMapsUrl) async {
    if (await canLaunchUrlString(googleMapsUrl)) {
      await launchUrlString(googleMapsUrl,
          mode: LaunchMode.externalApplication);
    } else {
      throw ("Could not open the map");
    }
  }
*/
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
