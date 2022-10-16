import 'package:flutter/material.dart';
import 'package:simply_halal/model/business_details.dart';
import 'package:simply_halal/network/network_api_client.dart';
import 'package:simply_halal/widgets/big_text.dart';
import 'package:simply_halal/widgets/small_text.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

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

                  return restaurantDetailsWidget(businessDetails);
                } else {
                  return const Text("No Data");
                }
              })
        ],
      )),
    );
  }

  Widget restaurantDetailsWidget(BusinessDetails businessDetails) {
    return Column(
      children: [
        // name of the business
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: BigText(
            text: businessDetails.name ?? '',
            align: TextAlign.center,
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              children: [
                // Main Image of the business
                imageRoundedBox(businessDetails.imageUrl ?? ''),

                // rating and favorite
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            BigText(
                              text: '${businessDetails.rating}/5',
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.favorite_outline),
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
                        text: businessDetails.location!.address1 ?? '',
                        size: 18,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SmallText(
                        text:
                            '${businessDetails.location!.city ?? ''}, ${businessDetails.location!.state ?? ''} ${businessDetails.location!.zipCode ?? ''}',
                        size: 18,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SmallText(
                        text: businessDetails.displayPhone ?? '',
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
                      SmallText(
                        text: '${businessDetails.name} restaurant menu',
                        size: 16,
                        color: Colors.blue,
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
                      BigText(text: 'Hours'),
                      SmallText(
                        text:
                            'Mon: ${toNormalTime(extractStartHours(0, businessDetails))} - ${toNormalTime(extractEndHours(0, businessDetails))}',
                        size: 14,
                      ),
                      SmallText(
                        text:
                            'Tue: ${toNormalTime(extractStartHours(1, businessDetails))} - ${toNormalTime(extractEndHours(0, businessDetails))}',
                        size: 14,
                      ),
                      SmallText(
                        text:
                            'Wed: ${toNormalTime(extractStartHours(2, businessDetails))} - ${toNormalTime(extractEndHours(0, businessDetails))}',
                        size: 14,
                      ),
                      SmallText(
                        text:
                            'Thurs: ${toNormalTime(extractStartHours(3, businessDetails))} - ${toNormalTime(extractEndHours(0, businessDetails))}',
                        size: 14,
                      ),
                      SmallText(
                        text:
                            'Fri: ${toNormalTime(extractStartHours(4, businessDetails))} - ${toNormalTime(extractEndHours(0, businessDetails))}',
                        size: 14,
                      ),
                      SmallText(
                        text:
                            'Sat: ${toNormalTime(extractStartHours(5, businessDetails))} - ${toNormalTime(extractEndHours(0, businessDetails))}',
                        size: 14,
                      ),
                      SmallText(
                        text:
                            'Sun: ${toNormalTime(extractStartHours(6, businessDetails))} - ${toNormalTime(extractEndHours(0, businessDetails))}',
                        size: 14,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ],
    );
  }

  // Helper functions
  String extractStartHours(int day, BusinessDetails businessDetails) {
    return businessDetails.hours![0].open![day].start ?? '';
  }

  String extractEndHours(int day, BusinessDetails businessDetails) {
    return businessDetails.hours![0].open![day].end ?? '';
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
