import 'package:flutter/material.dart';
import 'package:simply_halal/network/network_helper.dart';

import '../model/business.dart';
import '../network/simply_halal_api_endpoints.dart';
import '../network/network_service.dart';
import '../network/simply_halal_api_params.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: const Text(
                "Current Location",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Text((snapshot.data as List<Business>).toString());
                  } else {
                    return const Text('Loading');
                  }
                })
          ],
        ),
      ),
    );
  }

  Future<List<Business>?> getData() async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        url: SimplyHalalApiEndpoints.apiURL,
        queryParam: SimplyHalalApiParam.apiQuery(location: "NYC"));

    print("response status code --> ${response?.statusCode}");

    return await NetworkHelper.filterResponse(
        callback: _listOfBusinessFromJson,
        response: response,
        onFailureCallbackWithMessage: (errorType, msg) {
          print('Error Type: $errorType, Message: $msg');
          return null;
        });
  }

  List<Business> _listOfBusinessFromJson(json) => (json as List)
      .map((e) => Business.fromJson(e as Map<String, dynamic>))
      .toList();
}
