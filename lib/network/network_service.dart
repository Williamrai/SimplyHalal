import 'package:http/http.dart' as http;
import 'package:simply_halal/network/simply_halal_api_endpoints.dart';
import 'package:simply_halal/network/network_helper.dart';

enum RequestType { get, put, post }

class NetworkService {
  const NetworkService._();

  static Map<String, String> _getHeaders() => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${SimplyHalalApiEndpoints.apiKey}'
      };

  static Future<http.Response>? _createRequest({
    required RequestType requestType,
    required Uri uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    if (requestType == RequestType.get) {
      return http.get(uri, headers: headers);
    }

    if (requestType == RequestType.post) {
      return null;
    }

    return null;
  }

  static Future<http.Response?>? sendRequest({
    required RequestType requestType,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? queryParam,
  }) async {
    try {
      final fullHeader = _getHeaders();
      final fullUrl = NetworkHelper.concatURLWithParams(url, queryParam);
      final response = await _createRequest(
          requestType: requestType,
          uri: Uri.parse(fullUrl),
          headers: fullHeader,
          body: body);

      return response;
    } catch (e) {
      print('Error -> $e');
      return null;
    }
  }
}