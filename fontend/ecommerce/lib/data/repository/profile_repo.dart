import 'package:ecommerce/data/api/api_client.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getProfileUserList() async {
    return await apiClient.getData(AppConstants.PROFILE_URL);
  }
}
