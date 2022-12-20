import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:simply_halal/widgets/big_text.dart';
import 'package:simply_halal/widgets/small_text.dart';
import 'package:shimmer/shimmer.dart';

class BusinessCardView extends StatefulWidget {
  final String imageUrl;
  final String miles;
  final String name;
  final double rating;

  const BusinessCardView(
      {super.key,
      required this.imageUrl,
      required this.miles,
      required this.name,
      required this.rating});

  @override
  State<BusinessCardView> createState() => _BusinessCardViewState();
}

class _BusinessCardViewState extends State<BusinessCardView> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          isLoaded = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoaded ? imageRoundedBox(widget.imageUrl) : getShimmerLoading(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: widget.miles,
                    size: 16,
                  ),
                  ratingWidget(widget.rating)
                ],
              ),
              const SizedBox(height: 5),
              BigText(text: widget.name)
            ],
          ),
        ),
      ],
    );
  }

  Widget ratingWidget(double rating) {
    return Row(
      children: [
        const Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
        ),
        const SizedBox(
          width: 4,
        ),
        SmallText(
          text: rating.toString(),
          size: 18,
        )
      ],
    );
  }

  Widget imageRoundedBox(String url) {
    if (url.isEmpty) {
      // no image view
      url =
          "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg";
    }
    debugPrint("apple url: $url");

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(url)),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
    );
  }

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
