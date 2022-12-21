import 'package:flutter/material.dart';
import 'package:simply_halal/database/database_helper.dart';
import 'package:simply_halal/model/business.dart';
import 'package:simply_halal/model/current_location.dart';
import 'package:simply_halal/model/favorite_model.dart';
import 'package:simply_halal/network/network_enums.dart';
import 'package:simply_halal/network/network_helper.dart';
import 'package:simply_halal/network/network_service.dart';
import 'package:simply_halal/network/simply_halal_api_endpoints.dart';
import 'package:simply_halal/network/simply_halal_api_params.dart';
import 'package:simply_halal/screens/favorite_screen.dart';
import 'package:simply_halal/screens/home_screen.dart';
import 'package:simply_halal/screens/search_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:developer';

import 'package:simply_halal/utils.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  Future<List<Business>?>? businesses;

  @override
  void initState() {
    super.initState();

    businesses = getData();
  }

  @override
  Widget build(BuildContext context) {
    const navBarTopBorderColor = Color(0xffD9D9D9);
    return Scaffold(
      body: getCurrentScreen(currentPage),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: navBarTopBorderColor,
            border: Border(
                top: BorderSide(color: navBarTopBorderColor, width: 1.0))),
        child: NavigationBar(
          backgroundColor: Colors.white,
          destinations: [
            NavigationDestination(
                icon: Image.asset(
                  "images/home.png",
                  height: 20,
                  width: 20,
                ),
                label: ""),
            const NavigationDestination(icon: Icon(Icons.search), label: ""),
            const NavigationDestination(
                icon: Icon(Icons.favorite_outline), label: ""),
            // const NavigationDestination(
            //     icon: Icon(Icons.person_outline), label: "")
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
        ),
      ),
    );
  }

  Widget getCurrentScreen(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: FutureBuilder(
                future: businesses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    final List<Business> businesses =
                        snapshot.data as List<Business>;
                    return HomeScreen(businesses: businesses);
                  } else if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  } else {
                    return const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }));
      case 1:
        return const SearchScreen();

      case 2:
        // retrieve favorite model
        return FutureBuilder(
            future: getFavorites(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final favorites = snapshot.data as List<FavoriteModel>;
                return FavoriteScreen(favoriteModels: favorites);
              } else {
                List<FavoriteModel> favorites = [];
                return FavoriteScreen(favoriteModels: favorites);
              }
            }));

      // case 4:
      //   return const AccountScreen();

      default:
        return const HomeScreen(businesses: []);
    }
  }

  Future<List<FavoriteModel>?> getFavorites() async {
    return await DatabaseHelper.db.getAllFavorites();
  }

  // Current Location
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

  Future<String> getCurrentAddress() async {
    // retrieve current position
    Position position = await _determinePosition();
    Utils.currentLocLat = position.latitude;
    Utils.currentLocLong = position.longitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    debugPrint("apple location homes: ${placemarks}");
    debugPrint("apple location home: ${placemarks[0]}");

    CurrentLocation.streetName = placemarks[0].street ?? "";
    CurrentLocation.currentLocality = placemarks[0].postalCode ?? "";
    CurrentLocation.currentMetropolitian =
        placemarks[0].administrativeArea ?? "";
    return placemarks[0].postalCode ?? "";
  }

  Future<void> _refreshData(BuildContext context) async {
    setState(() {
      businesses = getData();
    });
  }

  Future<List<Business>?> getData() async {
    final location = await getCurrentAddress();

    if (Utils.hasLocationChanged(location)) {
      log("business: Api Call");

      final response = await NetworkService.sendGetRequestWithQuery(
          url: SimplyHalalApiEndpoints.apiURL,
          queryParam: SimplyHalalApiParam.apiQuery(location: location));

      List<Business> allBusiness = await NetworkHelper.filterResponse(
          callback: _listOfBusinessFromJson,
          response: response,
          parameterName: CallBackParameterName.allBusiness,
          onFailureCallbackWithMessage: (errorType, msg) {
            debugPrint('Error Type: $errorType; message: $msg');
            return null;
          });

      await DatabaseHelper.db.deleteBusinesses();

      for (Business business in allBusiness) {
        await DatabaseHelper.db.addBusiness(business);
      }

      Utils.currentLocation = location;
      return allBusiness;
    }

    final businesses = await DatabaseHelper.db.getAllBusiness();
    if ((businesses != null && businesses.isNotEmpty)) {
      log("business: db Call ${businesses.length}");
      return businesses;
    }

    return null;
  }

  List<Business> _listOfBusinessFromJson(json) => (json as List)
      .map((e) => Business.fromJson(e as Map<String, dynamic>))
      .toList();
}
