import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simply_halal/model/current_location.dart';
import 'package:simply_halal/utils.dart';

class SHLocationManager {

  SHLocationManager._();

  static Future<String> getCurrentAddress() async {
    // retrieve current position
    Position position = await _determinePosition();
    Utils.currentLocLat = position.latitude;
    Utils.currentLocLong = position.longitude;
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    debugPrint("apple location ${placemarks[0]}");
    CurrentLocation.currentLocality = placemarks[0].postalCode ?? "";
    CurrentLocation.currentMetropolitian =
        placemarks[0].administrativeArea ?? "";
    return placemarks[0].postalCode ?? "";
  }

  // Current Location
  static Future<Position> _determinePosition() async {
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

}