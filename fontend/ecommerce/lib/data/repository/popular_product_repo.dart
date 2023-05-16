import 'package:ecommerce/data/api/api_client.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    //end point url = url api

    return await apiClient.getData(AppConstants.POPULAR_PODUCT_URI);
  }
}
