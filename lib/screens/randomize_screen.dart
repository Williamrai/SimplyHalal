import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:simply_halal/model/business.dart';
import 'package:simply_halal/screens/restaurant_details_screen.dart';
import 'package:simply_halal/widgets/big_text.dart';

class RandomizeScreen extends StatefulWidget {
  final List<Business> business;

  const RandomizeScreen({Key? key, required this.business}) : super(key: key);

  @override
  State<RandomizeScreen> createState() => _RandomizeScreenState();
}

class _RandomizeScreenState extends State<RandomizeScreen> {
  final statusText = [
    "Getting Restaurant Information",
    "Searching an amazing restaurant for you",
    "Almost there",
    "Thank you for your patience."
  ];

  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: loadingWidget(),
    ));
  }

  Widget loadingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        AnimatedTextKit(animatedTexts: [
          RotateAnimatedText(statusText[0],
              textStyle: const TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
              )),
          RotateAnimatedText(statusText[1],
              textStyle: const TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
              )),
          RotateAnimatedText(statusText[2],
              textStyle: const TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
              )),
          RotateAnimatedText(statusText[3],
              textStyle: const TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
              )),
        ], isRepeatingAnimation: false, onFinished: () {
            Business randomBusiness = randomizeRestaurant(widget.business);
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RestaurantDetailScreen(
                    id: randomBusiness.id,
                    distance: randomBusiness.distance ?? 0)
              ),
            );
        }),
      ],
    );
  }

  Business randomizeRestaurant(List<Business> currentBusinesses) {
    debugPrint("length of businesses --> ${currentBusinesses.length}");
    var intValue = Random().nextInt(currentBusinesses.length);
    return widget.business[intValue];
    debugPrint(intValue.toString());
  }
}
