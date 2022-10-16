import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  TextAlign align;

  SmallText(
      {super.key,
      this.color,
      required this.text,
      this.size = 12,
      this.height = 1.2,
      this.align = TextAlign.left});

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
      textAlign: align,
    );
  }
}
