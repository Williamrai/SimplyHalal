import 'package:flutter/cupertino.dart';
import 'package:simply_halal/model/business_details.dart';
import 'package:simply_halal/network/network_enums.dart';
import 'package:simply_halal/network/network_helper.dart';
import 'package:simply_halal/network/network_service.dart';
import 'package:simply_halal/network/simply_halal_api_endpoints.dart';
import 'package:simply_halal/network/simply_halal_api_params.dart';

import '../model/business.dart';

class NetworkAPiClient {
  NetworkAPiClient._();

  static Future<BusinessDetails?> getBusinessDetails(String id) async {
    final response = await NetworkService.sendGetRequestWithParameter(
        url: SimplyHalalApiEndpoints.businessDetailsUrl, param: id);
    return await NetworkHelper.filterResponse(
        callback: _businessDetailsFromJson,
        response: response,
        parameterName: CallBackParameterName.businessDetails,
        onFailureCallbackWithMessage: (errorType, msg) {
          print('Error Type: $errorType; message: $msg');
          return null;
        });
  }

  static BusinessDetails _businessDetailsFromJson(json) =>
      BusinessDetails.fromJson(json);

}
