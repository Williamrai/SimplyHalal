import 'package:flutter/material.dart';
import 'package:simply_halal/model/favorite_model.dart';
import 'package:simply_halal/screens/account_screen.dart';
import 'package:simply_halal/screens/favorite_screen.dart';
import 'package:simply_halal/screens/home_screen.dart';
import 'package:simply_halal/screens/search_screen.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    const navBarTopBorderColor = Color(0xffD9D9D9);
    return Scaffold(
      body: getCurrentScreen(currentPage),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: navBarTopBorderColor,
            border: Border(
                top: BorderSide(color: navBarTopBorderColor, width: 1.0))),
        child: NavigationBar(
          backgroundColor: Colors.white,
          destinations: [
            NavigationDestination(
                icon: Image.asset(
                  "images/home.png",
                  height: 20,
                  width: 20,
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

  Widget getCurrentScreen(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return const HomeScreen();

      case 1:
        return const SearchScreen();

      case 2:
        // retrieve favorite model
        List<FavoriteModel> models = getFavoriteModel();
        return FavoriteScreen(favoriteModels: models);

      case 3:
        return const AccountScreen();

      default:
        return const HomeScreen();
    }
  }

  List<FavoriteModel> getFavoriteModel() {
    // dummy data
    List<FavoriteModel> favorites = [
      FavoriteModel(
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
          "Restro De Mango",
          0.2),
      FavoriteModel(
          "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
          "Meatyy Halal Diner",
          1.2),
      FavoriteModel(
          "https://images.unsplash.com/photo-1565958011703-44f9829ba187?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80",
          "Halal Cake and Go",
          0.8),
      FavoriteModel(
          "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
          "Bowls GetIt",
          1.4),
      FavoriteModel(
          "https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
          "Watery Ice Cream",
          2.3),
      FavoriteModel(
          "https://images.unsplash.com/photo-1609951651556-5334e2706168?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
          "Tipsy Bar",
          0.2),
      FavoriteModel(
          "https://images.unsplash.com/photo-1432139509613-5c4255815697?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80",
          "FoodLove Restuarant",
          0.2),
      FavoriteModel(
          "https://images.unsplash.com/photo-1565299507177-b0ac66763828?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=722&q=80",
          "Grab Burgers",
          0.2),
    ];

    // @TODO: retrieve list of favorite data from either local database or from the firebase or from any databse we create later

    return favorites;
  }
}
