import 'package:flutter/material.dart';
import 'package:simply_halal/widgets/big_text.dart';
import 'package:simply_halal/widgets/small_text.dart';

class BusinessCardView extends StatelessWidget {
  final String imageUrl;
  final String miles;
  final String name;

  const BusinessCardView(
      {super.key,
      required this.imageUrl,
      required this.miles,
      required this.name});

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
              imageRoundedBox(imageUrl),
              const SizedBox(height: 10),
              SmallText(
                text: miles,
                size: 16,
              ),
              const SizedBox(height: 5),
              BigText(text: name)
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
}
