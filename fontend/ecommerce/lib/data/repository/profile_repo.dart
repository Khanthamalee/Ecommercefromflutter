import 'package:ecommerce/data/api/api_client.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ProfileRepo {
  final ApiClient apiClient;
  ProfileRepo({required this.apiClient});

  Future<Response> getProfileUserList() async {
    //end point url = url api
    return await apiClient.getData(AppConstants.PROFILE_URL);
  }
}
