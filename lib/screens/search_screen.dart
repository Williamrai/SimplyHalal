import 'package:flutter/material.dart';
import 'package:simply_halal/database/database_helper.dart';
import 'package:simply_halal/model/business.dart';
import 'package:simply_halal/model/search_model.dart';
import 'package:simply_halal/network/network_api_client.dart';

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
              children:  [
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
                  onSubmitted: (businessName) {
                    debugPrint(businessName);
                    //@TODO: do the api call and only after successfull api call you need to insert the id, name of business to database
                    //@TODO: add FutureBuilder to call Api
                    // code to call business search API:
                    // NetworkAPiClient.getBusiness(businessName)
                    // this function should only be called after successfull api call: addToSearchDB(SearchModel(id: "id", businessName: value));
                              FutureBuilder(
              future: NetworkAPiClient.getBusiness(businessName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final BusinessSearch businessSearch =
                      snapshot.data as BusinessSearch;

                  return FutureBuilder(
                    future: checkIfSuccessfulCall(businessName),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        Utils.isIfSuccesfulCallClick = snapshot.data as bool;
                        return RestaurantWidget(
                            id: id,
                            businessName: businessName;
                      } else {
                        return const Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                    }),
                  );
                } else {
                  return const Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
              })
                    
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Recent Searches",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                // @TODO: create a list view
                  ListView.builder(
                itemCount: Business.length,
                itemBuilder: (context, index) {
                return ListTile(
                title: Text(this.businessSearch[index].businessName),
    );
  },
);


              ]),
        ),
      ),
    );
  }

 Future<bool> checkIfSuccesfulCall(BusinessName businessName) async {
    final searchBusiness = SearchModel(
        id: businessSearch.id ?? '',
        businessName: businessSearch.name ?? '',
    final searchbusiness =
        await addToSearchDB(SearchModel(id: "id", businessName: value));

    log("$business");
    if (business == null) {
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}

  void addToSearchDB(SearchModel searchModel) async {
    int res = await DatabaseHelper.db.addSearch(searchModel);
    debugPrint(res.toString());
  }

  // @TODO: create a function to retrieve list of recent search from the search_db
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }

}
