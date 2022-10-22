class Utils {
  static String currentLocation = "";

  static bool hasLocationChanged(String location) {
    return location != currentLocation;
  }
}
