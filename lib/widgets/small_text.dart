import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;

  SmallText(
      {super.key,
      this.color,
      required this.text,
      this.size = 12,
      this.height = 1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: 'OpenSans',
        height: height,
      ),
      textAlign: TextAlign.left,
    );
  }
}
