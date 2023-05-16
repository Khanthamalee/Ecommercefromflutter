import 'package:ecommerce/data/repository/profile_repo.dart';
import 'package:ecommerce/model/response_model.dart';
import 'package:get/get.dart';

class ProfileUserController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  ProfileUserController({required this.profileRepo});

  List<dynamic> _profileuserProductList = [];
  //getter method return list เอาไปใช้งาน
  List<dynamic> get profileuserProductList => _profileuserProductList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> getProfileUserList() async {
    Response response = await profileRepo.getProfileUserList();

    print(response.body);
    print(response.body.runtimeType);

    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _profileuserProductList = [];

      //จัดเรียงข้อมูลจาก API ให้ดึงง่าย
      Map<String, dynamic> user = response.body['products'][0]['user'];
      var phone = response.body['products'][0]['phone'];
      Map<String, dynamic> homeaddress =
          response.body['products'][0]['homeaddress'];
      Map<String, dynamic> officeaddress =
          response.body['products'][0]['officeaddress'];
      Map<String, dynamic> presentpositionaddress =
          response.body['products'][0]['presentpositionaddress'];
      var order_count = response.body['products'][0]['order_count'];

      // print("user : $user");
      // print("phone : $phone");
      // print("latitude : ${latitude}");
      // print("longitude : ${longitude}");
      // print("address : $address");
      // print("order_count : $order_count");

      //เพิ่มข้อมูลเข้าไปใน List
      _profileuserProductList.addAll({
        {'user': user},
        {'phone': phone},
        {'homeaddress': homeaddress},
        {'officeaddress': officeaddress},
        {'presentpositionaddress': presentpositionaddress},
        {'order_count': order_count}
      });
      print("_profileuserProductList : ${_profileuserProductList}");

      responseModel = ResponseModel(true, "จัดเรียงข้อมูลสำเร็จ");
      print("true in registration : ${responseModel.message}");
    } else {
      responseModel = ResponseModel(false, "ดึงข้อมูลไม่สำเร็จ");
      print("false in registration : ${responseModel.message}");
    }
    _isLoading = true;
    update();
    return responseModel;
  }
}
