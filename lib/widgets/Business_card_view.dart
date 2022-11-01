import 'package:flutter/material.dart';
import 'package:simply_halal/widgets/big_text.dart';
import 'package:simply_halal/widgets/small_text.dart';
import 'package:shimmer/shimmer.dart';

class BusinessCardView extends StatefulWidget {
  final String imageUrl;
  final String miles;
  final String name;

  const BusinessCardView(
      {super.key,
      required this.imageUrl,
      required this.miles,
      required this.name});

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
              SmallText(
                text: widget.miles,
                size: 16,
              ),
              const SizedBox(height: 5),
              BigText(text: widget.name)
            ],
          ),
        ),
      ],
    );
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
