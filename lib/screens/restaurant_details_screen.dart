import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simply_halal/database/database_helper.dart';
import 'package:simply_halal/model/business_details.dart';
import 'package:simply_halal/model/favorite_model.dart';
import 'package:simply_halal/network/network_api_client.dart';
import 'package:simply_halal/screens/menu_screen.dart';
import 'package:simply_halal/utils.dart';
import 'package:simply_halal/widgets/big_text.dart';
import 'package:simply_halal/widgets/small_text.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  final double distance;
  const RestaurantDetailScreen(
      {super.key, required this.id, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          FutureBuilder(
              future: NetworkAPiClient.getBusinessDetails(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final BusinessDetails businessDetails =
                      snapshot.data as BusinessDetails;

                  return FutureBuilder(
                    future: checkIfFavorited(businessDetails),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        Utils.isFavoriteClick = snapshot.data as bool;
                        return RestaurantDetailsWidget(
                            businessDetails: businessDetails,
                            distance: distance);
                      } else {
                        return const SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
                  );
                } else {
                  return const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              })
        ],
      )),
    );
  }

  Future<bool> checkIfFavorited(BusinessDetails businessDetails) async {
    final favoriteBusiness = FavoriteModel(
        id: businessDetails.id ?? '',
        imageUrl: businessDetails.imageUrl ?? '',
        businessName: businessDetails.name ?? '',
        distance: distance);
    final business =
        await DatabaseHelper.db.getFavoriteBusiness(favoriteBusiness);

    log("$business");
    if (business == null) {
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}

class RestaurantDetailsWidget extends StatefulWidget {
  final BusinessDetails businessDetails;
  final double distance;
  const RestaurantDetailsWidget(
      {super.key, required this.businessDetails, required this.distance});

  @override
  State<RestaurantDetailsWidget> createState() =>
      _RestaurantDetailsWidgetState();
}

class _RestaurantDetailsWidgetState extends State<RestaurantDetailsWidget> {
  bool isFavoriteClick = Utils.isFavoriteClick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // name of the business
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: BigText(
                text: widget.businessDetails.name ?? '',
                align: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: [
                    // Main Image of the business
                    imageRoundedBox(widget.businessDetails.imageUrl ?? ''),

                    // rating and favorite
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              BigText(
                                text: '${widget.businessDetails.rating}/5',
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavoriteClick = !isFavoriteClick;
                                Utils.isFavoriteClick = isFavoriteClick;
                              });
                              _addOrDeleteFavoriteModel();
                            },
                            child: (isFavoriteClick == false)
                                ? const Icon(Icons.favorite_outline)
                                : const Icon(Icons.favorite, color: Colors.red),
                          )
                        ],
                      ),
                    ),

                    // Address
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                            text: widget.businessDetails.location?.address1 ?? '',
                            size: 18,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SmallText(
                            text:
                                '${widget.businessDetails.location?.city ?? ''}, ${widget.businessDetails.location?.state ?? ''} ${widget.businessDetails.location?.zipCode ?? ''}',
                            size: 18,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SmallText(
                            text: widget.businessDetails.displayPhone ?? '',
                            size: 18,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),

                    // Menu
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: 'Menu:',
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MenuScreen(menuUrl: widget.businessDetails.url ?? ""),
                                ),
                              );
                            },
                            child: SmallText(
                              text:
                                  '${widget.businessDetails.name} restaurant menu',
                              size: 16,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ),

                  // Hours
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.businessDetails.hours == null
                            ? Container()
                            : BigText(text: 'Hours'),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.businessDetails.hours == null
                                ? 0
                                : widget.businessDetails.hours?[0].open!.length,
                            itemBuilder: ((context, index) {
                              final days = [
                                'Sun',
                                'Mon',
                                "Tue",
                                'Wed',
                                'Thurs',
                                'Fir',
                                'Sat'
                              ];
                              return hoursView(days[index], toNormalTime(extractStartHours(index, widget.businessDetails)), toNormalTime(extractEndHours(index, widget.businessDetails)));

                            }))
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    )
    );
  }

  // Hours Widget
  Widget hoursView(String day, String startHours, String endHours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0), child: BigText(text: day, size: 16,)),
        SmallText(text: "$startHours - $endHours", size: 16,)
      ],
    );
  }

  // Helper functions
  void _addOrDeleteFavoriteModel() {
    final favoriteBusiness = FavoriteModel(
      id: widget.businessDetails.id,
      imageUrl: widget.businessDetails.imageUrl ?? '',
      businessName: widget.businessDetails.name ?? '',
      distance: widget.distance,
    );

    if (isFavoriteClick == true) {
      log("add");
      _addFavoriteBusiness(favoriteBusiness);
    } else {
      _deleteFavoriteBusiness(favoriteBusiness);
      log("delete");
    }
  }

  Future<FavoriteModel?> getFavoriteBusinessToDelete(
      FavoriteModel favoriteModel) async {
    final favoriteBusinessToDelete =
        await DatabaseHelper.db.getFavoriteBusiness(favoriteModel);

    return favoriteBusinessToDelete;
  }

  void _addFavoriteBusiness(FavoriteModel favoriteBusiness) async {
    await DatabaseHelper.db.addFavorite(favoriteBusiness);
  }

  void _deleteFavoriteBusiness(FavoriteModel favoriteBusiness) async {
    final favoriteBusinessToDelete =
        await getFavoriteBusinessToDelete(favoriteBusiness);
    log("${favoriteBusinessToDelete?.id}, ${favoriteBusinessToDelete?.businessName}");

    await DatabaseHelper.db.deleteFavorite(favoriteBusinessToDelete!);
  }

  String extractStartHours(int day, BusinessDetails businessDetails) {
    return businessDetails.hours?[0].open?[day].start ?? '';
  }

  String extractEndHours(int day, BusinessDetails businessDetails) {
    return businessDetails.hours?[0].open?[day].end ?? '';
  }

  String toNormalTime(String time) {
    int integerTime = int.parse(time).abs();

    String newTime = "";
    if (integerTime > 1200) {
      newTime = (integerTime - 1200).toString();
    } else {
      newTime = integerTime.toString();
    }

    String formattedString = "";
    if (newTime.length <= 3) {
      formattedString = "0$newTime";
    } else {
      formattedString = newTime;
    }

    final value = formattedString.replaceAllMapped(
        RegExp(r"..(?!$)"), (match) => "${match.group(0)}:");

    if (integerTime <= 1200) {
      formattedString = '$value am';
    } else {
      formattedString = '$value pm';
    }
    return formattedString;
  }

  Widget imageRoundedBox(String url) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(url)),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
    );
  }
}
