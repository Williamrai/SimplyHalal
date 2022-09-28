import 'package:flutter/material.dart';
import 'package:simply_halal/root_page.dart';

void main() {
  runApp(const SimplyHalalApp());
}

class SimplyHalalApp extends StatelessWidget {
  const SimplyHalalApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}
