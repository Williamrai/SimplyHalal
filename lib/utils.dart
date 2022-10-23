class Utils {
  static String currentLocation = "";
  static double currentLocLat = 0.0;
  static double currentLocLong = 0.0;
  static bool isFavoriteClick = false;

  static bool hasLocationChanged(String location) {
    return location != currentLocation;
  }
}
