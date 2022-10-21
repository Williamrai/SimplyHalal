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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Search",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
                SizedBox(height: 10),
                TextField(
                  maxLines: 1,
                  style: TextStyle(fontSize: 15, fontFamily: 'OpenSans'),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    fillColor: Color.fromARGB(255, 230, 229, 229),
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Search for halal foods or restaurants',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Recent Searches",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ]),
        ),
      ),
    );
  }
}
