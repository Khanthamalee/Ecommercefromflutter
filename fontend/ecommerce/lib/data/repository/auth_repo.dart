import 'package:ecommerce/data/api/api_client.dart';
import 'package:ecommerce/model/create_token_model.dart';
import 'package:ecommerce/model/signup_body_model.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  Future<Response> registration(SignUpBody signUpBody) async {
    // print("signUpBody.toJson() : ${signUpBody.toJson()}");
    // print(
    //     "signUpBody.toJson().runtimeType : ${signUpBody.toJson().runtimeType}");
    return await apiClient.postData(
        AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<Response> createtoken(LoginData loginData) async {
    Response response = await apiClient.postData(
        AppConstants.CREATETOKEN_URL, loginData.toJson());
    print(AppConstants.CREATETOKEN_URL);
    print("loginData.toJson() : ${loginData.toJson()["username"]}");
    print("response in createtoken : ${response}");
    print("response.body in createtoken : ${response.body}");
    return response;
  }

  Future<Response> Loginuser(LoginData loginData, String token) async {
    Response response = await apiClient.postData(AppConstants.LOGIN_URL, {
      "username": loginData.toJson()["username"].toString(),
      "password": loginData.toJson()["password"].toString()
    });

    print("AppConstants.LOGIN_URL : ${AppConstants.LOGIN_URL}");
    print("loginData.toJson() : ${loginData.toJson()}");
    print("response.body : ${response.body['token']}");

    //API ที่เราใช้ ต้องใช้ Token ในการ permission เข้าถึงข้อมูล ดังนั้นเลยบันทึก Token เพื่อใช้ในการ get ข้อมูล
    apiClient.token = response.body['token'];
    apiClient.updateHeader(response.body['token']);

    print("loginData.toJson()['username']:${loginData.toJson()['username']}");
    print("loginData.toJson()['password']:${loginData.toJson()['password']}");

    saveUserusernameAndPasswordToAppConstants(
        "${response.body['username']}", "${response.body['password']}");

    await sharedPreferences.setString(
        AppConstants.TOKEN, response.body['token']);

    return response;
  }

  //ใช้ sharedPreferences ในการบันทึกข้อมูลเป็นพวกค่าคงที่ และนำไปใช้ตรวจสอบการ login ของ user
  Future<bool> saveUserTokenToAppConstants(String token) async {
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserusernameAndPasswordToAppConstants(
      String username, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USERNAME, username);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool userLoggedIn() {
    sharedPreferences.containsKey(AppConstants.TOKEN);
    print(
        "userLoggedIn : ${sharedPreferences.containsKey(AppConstants.TOKEN)}");
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.USERNAME);

    apiClient.token = '';
    apiClient.updateHeader('');

    return true;
  }
}
