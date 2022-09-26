import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Column(
          children: const [
            Text(
              "Search",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
          ],
        ),
      )),
    );
  }
}
