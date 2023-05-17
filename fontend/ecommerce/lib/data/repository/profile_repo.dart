import 'package:ecommerce/data/api/api_client.dart';
import 'package:ecommerce/model/profile_model.dart';
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

  List<String> profileuserdata = [];

  Future<void> saveprofileuser(
      Map<String, dynamic> user,
      String phone,
      Map<String, dynamic> homeaddress,
      Map<String, dynamic> officeaddress,
      Map<String, dynamic> presentpositionaddress,
      int ordercount) async {
    profileuserdata.addAll({
      user.toString(),
      phone.toString(),
      homeaddress.toString(),
      officeaddress.toString(),
      officeaddress.toString(),
      presentpositionaddress.toString(),
      ordercount.toString()
    });

    print("profileuserdata : ${profileuserdata}");
    print("profileuserdata.type : ${profileuserdata.runtimeType}");
    print(
        "sharedPreferences.setStringList : ${await sharedPreferences.setStringList(AppConstants.PROFILE_USERDATA, profileuserdata)}");
    await sharedPreferences.setStringList(
        AppConstants.PROFILE_USERDATA, profileuserdata);
  }
}
