import 'package:ecommerce/util/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  //ประกาศตัวแปร
  late String token;
  final String appBaseUrl;

  //Dictionary name _mainHeader
  late Map<String, String> _mainHeader;

  //Default Contructor
  ApiClient({required this.appBaseUrl}) {
    //input appBaseUrl return baseUrl,timeout,token,_mainHeader
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 20);
    token = AppConstants.TOKEN;
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-16',
      'Authorization': 'Bearer $token',
    };
  }
  Future<Response> getData(
    String uri,
  ) async {
    try {
      Response response = await get(uri);
      print("1. baseUrl : $baseUrl");
      print("2. uri : $uri ===");
      print("response.body.runtimeType ${response.body.runtimeType}");

      return response;
    } catch (e) {
      //ถ้าพบ error ให้ statusCode: 1 และ error
      //print("error = $e");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
