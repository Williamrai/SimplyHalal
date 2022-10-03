import 'package:flutter/material.dart';
import 'package:simply_halal/model/favorite_model.dart';
import 'package:simply_halal/widgets/big_text.dart';
import 'package:simply_halal/widgets/small_text.dart';

class FavoriteScreen extends StatelessWidget {
  final List<FavoriteModel> favoriteModels;

  const FavoriteScreen({super.key, required this.favoriteModels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Column(children: [
          // Screen Title
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "My Favorites",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
          ),
          // Body
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: favoriteModels.length,
                itemBuilder: (context, index) {
                  return favoriteView(
                      imageUrl: favoriteModels[index].imageUrl,
                      businessName: favoriteModels[index].businessName,
                      distance: favoriteModels[index].distance);
                }),
          )
        ]),
      )),
    );
  }

  // Card View of the favorite screen
  Widget favoriteView(
      {required String imageUrl,
      required String businessName,
      required double distance}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          imageRoundedBox(imageUrl),
          Expanded(
            child: Container(
              height: 100,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(
                    text: businessName,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SmallText(text: "$distance mi")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget imageRoundedBox(String url) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(url)),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
    );
  }
}
