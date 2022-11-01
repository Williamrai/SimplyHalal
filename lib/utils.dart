import 'dart:math';

import 'package:simply_halal/model/business_details.dart';
import 'package:vector_math/vector_math.dart';

class Utils {
  static String currentLocation = "";
  static double currentLocLat = 0.0;
  static double currentLocLong = 0.0;
  static bool isFavoriteClick = false;

  static bool hasLocationChanged(String location) {
    return location != currentLocation;
  }

  static double getDistanceInMiles(double distanceInMeters) {
    return distanceInMeters * 0.000621371;
  }

  static double calculateDistance(Coordinates businessLocation) {
    final currenLocationLat = radians(currentLocLat);
    final currentLocationLong = radians(currentLocLong);
    final businessLocationLat = radians(businessLocation.latitude!);
    final businessLocationLong = radians(businessLocation.longitude!);

    double dLon = businessLocationLong - currentLocationLong;
    double dlat = businessLocationLat - currenLocationLat;
    double a = pow(sin(dlat / 2), 2) +
        cos(currenLocationLat) * cos(businessLocationLat) +
        pow(sin(dLon / 2), 2);

    double c = 2 * asin(sqrt(a));
    double r = 3956;
    return c * r;
  }
}
