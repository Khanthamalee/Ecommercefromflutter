import 'package:ecommerce/data/api/api_client.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    //end point url = url api
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
