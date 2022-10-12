import 'dart:convert';

import 'package:simply_halal/network/network_enums.dart';
import 'package:simply_halal/network/network_typedef.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  const NetworkHelper._();

  static String concatURLWithParams(
      String url, Map<String, String>? queryParameters) {
    if (url.isEmpty) return url;
    if (queryParameters == null || queryParameters.isEmpty) {
      return url;
    }

    final StringBuffer stringBuffer = StringBuffer("$url?");
    queryParameters.forEach((key, value) {
      if (value.toLowerCase() == '') return;
      //if (value.contains(' ')) throw Exception('Invalid Input Exception');
      stringBuffer.write('$key=$value&');
    });
    final result = stringBuffer.toString();
    return result.substring(0, result.length - 1);
  }

  static bool _isValidResponse(json) {
    return json != null && json['error'] == null;
  }

  static R filterResponse<R>(
      {required NetworkCallback callback,
      required http.Response? response,
      required NetworkOnFailureCallbackWithMessage onFailureCallbackWithMessage,
      CallBackParameterName parameterName =
          CallBackParameterName.allBusiness}) {
    try {
      if (response == null || response.body.isEmpty) {
        return onFailureCallbackWithMessage(
            NetworkResponseErrorType.reponseEmpty, 'Empty Response');
      }

      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (_isValidResponse(json)) {
          return callback(parameterName.getJson(json));
        }
      } else if (response.statusCode == 1708) {
        return onFailureCallbackWithMessage(
            NetworkResponseErrorType.socket, 'Socket error');
      }
      return onFailureCallbackWithMessage(
          NetworkResponseErrorType.didNotSucceed, 'Unknown Error');
    } catch (e) {
      return onFailureCallbackWithMessage(
          NetworkResponseErrorType.exception, 'Exception $e');
    }
  }
}
