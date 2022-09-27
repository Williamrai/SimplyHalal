import 'package:flutter/material.dart';
import 'package:simply_halal/screens/account_screen.dart';
import 'package:simply_halal/screens/favorite_screen.dart';
import 'package:simply_halal/screens/home_screen.dart';
import 'package:simply_halal/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    const navBarTopBorderColor = Color(0xffD9D9D9);
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: navBarTopBorderColor,
            border: Border(
                top: BorderSide(color: navBarTopBorderColor, width: 1.0))),
        child: NavigationBar(
          surfaceTintColor: Colors.red,
          backgroundColor: Colors.white,
          destinations: [
            NavigationDestination(
                icon: Image.asset(
                  "images/home.png",
                  height: 20,
                  width: 20,
                  color: Colors.black,
                ),
                label: ""),
            const NavigationDestination(icon: Icon(Icons.search), label: ""),
            const NavigationDestination(
                icon: Icon(Icons.favorite_outline), label: ""),
            const NavigationDestination(
                icon: Icon(Icons.person_outline), label: "")
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
        ),
      ),
    );
  }
}
