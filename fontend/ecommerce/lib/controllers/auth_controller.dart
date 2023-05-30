import 'package:ecommerce/data/repository/auth_repo.dart';
import 'package:ecommerce/model/create_token_model.dart';
import 'package:ecommerce/model/response_model.dart';
import 'package:ecommerce/model/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();

    Response response = await authRepo.registration(signUpBody);

    late ResponseModel responseModel;

    if (response.statusCode == 201) {
      responseModel = ResponseModel(true, response.body.toString());
      print("true in registration : ${responseModel.message}");
    } else {
      final Map errormessage = Map.from(response.body);
      print("errormessage : ${errormessage}");
      print("errormessage.runtimeType : ${errormessage.runtimeType}");
      //List<dynamic> errormessagelist = [];

      List<dynamic>? usererror = errormessage["username"];
      var usererrormessage;
      if (usererror != null) {
        usererrormessage = "เบอร์นี้มีในระบบแล้ว กรุณาใช้เบอร์ใหม่";
      } else {
        usererrormessage = "เบอร์โทรศัพท์ของคุณผ่าน";
      }

      List<dynamic>? emailerror = errormessage["email"];
      var emailerrormessage;
      if (emailerror != null) {
        emailerrormessage = "อีเมลล์นี้มีในระบบแล้ว กรุณาใช้อีเมลล์ใหม่";
      } else {
        emailerrormessage = "อีเมลล์ของคุณผ่าน";
      }

      List<dynamic>? passworderror = errormessage["password"];
      var passworderrormessage;
      if (passworderror != null) {
        passworderrormessage = "รหัสต้องมีตัวอักษร ตัวเลข และสัญลัษณ์ค่ะ";
      } else {
        passworderrormessage = "รหัสผ่านของคุณยอดเยี่ยม";
      }

      responseModel = ResponseModel(false,
          "${usererrormessage}\n${emailerrormessage}\n${passworderrormessage} ");
      print("false in registration : ${responseModel.message}");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> loginuser(LoginData loginData) async {
    _isLoading = true;
    update();
    Response response = await authRepo.Loginuser(
        loginData, authRepo.createtoken(loginData).toString());
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body['token']);
      authRepo.saveUserTokenToAppConstants("${response.body['token']}");
      print("true in loginuser : ${responseModel.message}");
    } else {
      responseModel = ResponseModel(false, "${response.statusCode}");
      print(
          "false in loginuser :  ${responseModel.message} ${response.statusCode}");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool userlogout() {
    return authRepo.clearSharedData();
  }
}
