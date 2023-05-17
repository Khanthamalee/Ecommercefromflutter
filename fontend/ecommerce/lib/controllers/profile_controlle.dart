import 'package:ecommerce/data/repository/profile_repo.dart';
import 'package:ecommerce/model/profile_model.dart';
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
    // late ProfileModel profileModel;
    if (response.statusCode == 200) {
      _profileuserProductList = [];

      //จัดเรียงข้อมูลจาก API ให้ดึงง่าย
      Map<String, dynamic> user = response.body['products'][0]['user'];
      var phone = response.body['products'][0]['phone'];

      // List<dynamic?>? usererror = errormessage["username"];
      // var usererrormessage;
      // if (usererror != null) {
      //   usererrormessage = "เบอร์นี้มีในระบบแล้ว กรุณาใช้เบอร์ใหม่";
      // } else {
      //   usererrormessage = "เบอร์โทรศัพท์ของคุณผ่าน";
      // }

      Map<String, dynamic> homeaddress =
          response.body['products'][0]['homeaddress'];
      if (homeaddress["homeaddress_id"] == '') {
        homeaddress = response.body['products'][0]['homeaddress'];
        homeaddress["homeaddress_id"] = 100000000000000000;
        homeaddress["latitude"] = "13.72917";
        homeaddress["longitude"] = "100.52389";
        homeaddress["addressname"] = "ไม่มีข้อมูล";
        homeaddress["address"] = "ไม่มีข้อมูล";
        homeaddress["tombon"] = "ไม่มีข้อมูล";
        homeaddress["amphure"] = "ไม่มีข้อมูล";
        homeaddress["city"] = "ไม่มีข้อมูล";
        homeaddress["zip_code"] = "ไม่มีข้อมูล";
        homeaddress["type_id"] = 3;
        print("ไม่มี homeaddress_id ");
        print(homeaddress);
      } else {
        homeaddress = response.body['products'][0]['homeaddress'];
        print("มี homeaddress_id");
      }

      Map<String, dynamic> officeaddress =
          response.body['products'][0]['officeaddress'];
      if (officeaddress["officeaddress_id"] == '') {
        officeaddress = response.body['products'][0]['officeaddress'];
        officeaddress["officeaddress_id"] = 100000000000000000;
        officeaddress["latitude"] = "13.72917";
        officeaddress["longitude"] = "100.52389";
        officeaddress["addressname"] = "ไม่มีข้อมูล";
        officeaddress["address"] = "ไม่มีข้อมูล";
        officeaddress["tombon"] = "ไม่มีข้อมูล";
        officeaddress["amphure"] = "ไม่มีข้อมูล";
        officeaddress["city"] = "ไม่มีข้อมูล";
        officeaddress["zip_code"] = "ไม่มีข้อมูล";
        officeaddress["type_id"] = 3;
        print("ไม่มี officeaddress_id ");
        print(officeaddress);
      } else {
        officeaddress = response.body['products'][0]['officeaddress'];
        print("มี officeaddress_id");
      }
      print("homeaddress : ${homeaddress}");
      Map<String, dynamic> presentpositionaddress =
          response.body['products'][0]['presentpositionaddress'];
      if (presentpositionaddress["presentpositionaddress_id"] == '') {
        presentpositionaddress =
            response.body['products'][0]['presentpositionaddress'];
        presentpositionaddress["presentpositionaddress_id"] =
            100000000000000000;
        presentpositionaddress["latitude"] = "13.72917";
        presentpositionaddress["longitude"] = "100.52389";
        presentpositionaddress["addressname"] = "ไม่มีข้อมูล";
        presentpositionaddress["address"] = "ไม่มีข้อมูล";
        presentpositionaddress["tombon"] = "ไม่มีข้อมูล";
        presentpositionaddress["amphure"] = "ไม่มีข้อมูล";
        presentpositionaddress["city"] = "ไม่มีข้อมูล";
        presentpositionaddress["zip_code"] = "ไม่มีข้อมูล";
        presentpositionaddress["type_id"] = 3;
        print("ไม่มี presentpositionaddress_id ");
        print(officeaddress);
      } else {
        presentpositionaddress =
            response.body['products'][0]['presentpositionaddress'];
        print("มี presentpositionaddress_id");
      }
      var order_count;
      if (order_count == '') {
        order_count = 0;

        print("order_count ยังไม่มี");
      } else {
        order_count = response.body['products'][0]['order_count'];
        print("order_count มีแล้ว");
      }

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
      print("_profileuserProductList :${_profileuserProductList}");

      profileRepo.saveprofileuser(
          user,
          phone,
          {"homeaddress": homeaddress},
          {"officeaddress": officeaddress},
          {"presentpositionaddress": presentpositionaddress},
          order_count);
      print("_profileuserProductList : ${_profileuserProductList}");

      // profileModel = ProfileModel(
      //     user: user,
      //     phone: phone,
      //     homeaddress: homeaddress,
      //     officeaddress: officeaddress,
      //     presentpositionaddress: presentpositionaddress,
      //     orderCount: order_count,
      //     typeId: 4);

      responseModel = ResponseModel(true, "จัดเรียงข้อมูลสำเร็จ");
      print("true in registration : ${responseModel.message}");
    } else {
      responseModel = ResponseModel(false, "ดึงข้อมูลไม่สำเร็จ");
      print("false in registration : จัดเรียงข้อมูลไม่สำเร็จ");
    }
    _isLoading = true;
    update();
    return responseModel;
  }
}
