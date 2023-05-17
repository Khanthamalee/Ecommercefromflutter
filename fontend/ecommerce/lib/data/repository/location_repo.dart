import 'package:ecommerce/data/api/api_client.dart';
import 'package:ecommerce/model/address_model.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/profile_model.dart';

class LocationRepo {
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(LatLng latlng) async {
    print(latlng.latitude);
    print(latlng.longitude);
    Response response = await apiClient.postData(AppConstants.GEOCODE_URI,
        {"latitude": latlng.latitude, "longitude": latlng.longitude});
    // Response response = await apiClient.getData('${AppConstants.GEOCODE_URI}'
    //     '?lat=${latlng.latitude}&lng=${latlng.longitude}');
    print("response.body : ${response.body}");
    print(response.runtimeType);
    return response;
  }

  String getUserAddress() {
    print(
        "sharedPreferences.getString(AppConstants.PROFILE_USERDATA)  : ${sharedPreferences.getString(AppConstants.PROFILE_USERDATA)}");
    return sharedPreferences.getString(AppConstants.PROFILE_USERDATA) ?? "";
  }

  Future<Response> addDatatoProfileuser(ProfileModel profileModel) async {
    return await apiClient.putData(
        AppConstants.ADD_USER_ADDRESS, profileModel.toJson());
  }
}
