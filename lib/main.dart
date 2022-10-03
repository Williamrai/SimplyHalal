import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simply_halal/root_page.dart';

void main() {
  runApp(const SimplyHalalApp());
}

class SimplyHalalApp extends StatelessWidget {
  const SimplyHalalApp({super.key});
  @override
  Widget build(BuildContext context) {
    const appColor = Color(0xff488B49);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: appColor));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RootPage(),
    );
  }
}
