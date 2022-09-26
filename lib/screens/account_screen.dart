import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Column(children: const [
          Text(
            "User Name",
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
                fontSize: 30),
          )
        ]),
      )),
    );
  }
}
