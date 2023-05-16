import 'package:ecommerce/util/app_constants.dart';
import 'package:get/get.dart';

class ApiGoogleMap extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;

  late Map<String, String> _mainHeader;

  ApiGoogleMap({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 20);
    token = AppConstants.TOKEN;
    _mainHeader = {
      'Content-type': 'application/json; charset=utf-8',
      'Authorization': 'Token $token',
    };
  }

  void updateHeader(String token) {
    _mainHeader = {
      'Content-type': 'application/json; charset=utf-8',
      'Authorization': 'Token $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      print("_mainHeader : ${_mainHeader}");
      Response response = await get(uri, headers: headers ?? _mainHeader);
      print("1. baseUrlget : $baseUrl");
      print("2. uriget : $uri ===");
      print("response.body ${response.body}");
      print("response.body.runtimeTypeget ${response.body.runtimeType}");

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body);
      print("uripost : ${uri} , bodypost : ${body}");

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
