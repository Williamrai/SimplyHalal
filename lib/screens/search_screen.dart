import 'package:flutter/material.dart';
import 'package:simply_halal/SHLocationManager.dart';
import 'package:simply_halal/database/database_helper.dart';
import 'package:simply_halal/model/business.dart';
import 'package:simply_halal/model/business_details.dart';
import 'package:simply_halal/model/current_location.dart';
import 'package:simply_halal/model/search_model.dart';
import 'package:simply_halal/network/network_api_client.dart';
import 'package:simply_halal/network/network_enums.dart';
import 'package:simply_halal/network/network_helper.dart';
import 'package:simply_halal/network/network_service.dart';
import 'package:simply_halal/network/simply_halal_api_endpoints.dart';
import 'package:simply_halal/network/simply_halal_api_params.dart';
import 'package:simply_halal/screens/home_screen.dart';
import 'package:simply_halal/utils.dart';
import 'package:simply_halal/widgets/small_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String businessName = "";
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                addToSearchDB(SearchModel(businessName: businessName));
                getData(businessName).then((businesses) => {
                      if (businesses != null)
                        {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(businesses: businesses),
                            ),
                          )
                        }
                    });
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
            FutureBuilder(
                future: DatabaseHelper.db.getAllRecentSearch(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<SearchModel> datas =
                        snapshot.data as List<SearchModel>;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: datas.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 10),
                                child: SmallText(
                                  text: datas[index].businessName,
                                  size: 18,
                                ),
                              ),
                              onTap: () => {
                                loadProgress(),
                                getData(businessName).then((businesses) => {
                                      if (businesses != null)
                                        {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                  businesses: businesses),
                                            ),
                                          )
                                        }
                                    })
                              },
                            );
                          }),
                    );
                  } else {
                    return const Text("No Recent Searches");
                  }
                })
          ]),
        ),
      ),
    );
  }

  void loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  void addToSearchDB(SearchModel searchModel) async {
    int res = await DatabaseHelper.db.addSearch(searchModel);
    debugPrint(res.toString());
  }

  Future<List<Business>?> getData(String businessName) async {
    final location = await SHLocationManager.getCurrentAddress();
    final response = await NetworkService.sendGetRequestWithQuery(
        url: SimplyHalalApiEndpoints.apiURL,
        queryParam: SimplyHalalApiParam.searchQuery(
            location: location, businessName: businessName));

    List<Business> allBusiness = await NetworkHelper.filterResponse(
        callback: _listOfBusinessFromJson,
        response: response,
        parameterName: CallBackParameterName.allBusiness,
        onFailureCallbackWithMessage: (errorType, msg) {
          debugPrint('Error Type: $errorType; message: $msg');
          return null;
        });

    return allBusiness;
  }

  List<Business> _listOfBusinessFromJson(json) => (json as List)
      .map((e) => Business.fromJson(e as Map<String, dynamic>))
      .toList();
}
