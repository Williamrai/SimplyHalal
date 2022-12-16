import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simply_halal/model/current_location.dart';
import 'package:simply_halal/screens/randomize_screen.dart';
import 'package:simply_halal/screens/restaurant_details_screen.dart';
import 'package:simply_halal/utils.dart';
import 'package:simply_halal/widgets/Business_card_view.dart';
import '../model/business.dart';

class HomeScreen extends StatelessWidget {
  final List<Business> businesses;

  const HomeScreen({super.key, required this.businesses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                CurrentLocation.streetName == "" ? "${CurrentLocation.currentMetropolitian}, ${CurrentLocation.currentLocality}"
                    : "${CurrentLocation.streetName}, ${CurrentLocation.currentMetropolitian}, ${CurrentLocation.currentLocality}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: businesses.length,
                    itemBuilder: (context, index) {
                      final business = businesses[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetailScreen(
                                  id: business.id,
                                  distance: business.distance ?? 0),
                            ),
                          );
                        },
                        child: BusinessCardView(
                            imageUrl: business.imageUrl,
                            miles:
                                "${Utils.getDistanceInMiles(business.distance!).toStringAsFixed(2)} mi",
                            name: business.name),
                      );
                    })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          "images/shuffle.png",
          height: 20,
          width: 20,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RandomizeScreen(business: businesses),
          ));
        },
      ),
    );
  }
}
