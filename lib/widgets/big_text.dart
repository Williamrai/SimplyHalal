import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextAlign align;

  BigText(
      {super.key,
      this.color,
      required this.text,
      this.size = 20,
      this.align = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w700,
      ),
      textAlign: align,
    );
  }
}
