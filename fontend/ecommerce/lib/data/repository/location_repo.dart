import 'package:ecommerce/data/api/api_client.dart';
import 'package:ecommerce/model/address_model.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        "sharedPreferences.getString(AppConstants.USER_ADDRESS) :${sharedPreferences.getString(AppConstants.USER_ADDRESS)}");
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.putData(
        AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }
}
