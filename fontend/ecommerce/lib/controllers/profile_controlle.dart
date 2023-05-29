import 'package:ecommerce/controllers/location_controller.dart';
import 'package:ecommerce/data/repository/profile_repo.dart';
import 'package:ecommerce/model/Profileusermodel.dart';
import 'package:ecommerce/model/address_model.dart';
import 'package:ecommerce/model/positiontoMapModel.dart';
import 'package:ecommerce/model/profile_stringModel.dart';
import 'package:ecommerce/model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ProfileUserController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  ProfileUserController({required this.profileRepo});

  List<dynamic> _profileuserProductList = [];
  //getter method return list เอาไปใช้งาน
  List<dynamic> get profileuserProductList => _profileuserProductList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProfileuserModel? _profileuserModel;
  ProfileuserModel? get profileiserModel => _profileuserModel;

  // late AddressModel _addressModel;
  // AddressModel get addressModel => _addressModel;

  Future<ResponseModel> getProfileUserList() async {
    Response response = await profileRepo.getProfileUserList();

    print("response.body in getProfileUserList ${response.body[0]}");
    print("response.body[0].runtimeType ${response.body[0].runtimeType}");

    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _profileuserProductList = [];

      //_profileuserModel = ProfileuserModel.fromJson((response.body[0]));
      // if (_profileuserModel == null) {
      //   print("Nall Kaaaaa");
      // } else {
      //   print("object profileuserModel : ${_profileuserModel!}");
      //   print(
      //       "object _profileuserModel : ${_profileuserModel!.user!.username}");
      // }

      Map<String, dynamic> user = response.body[0]['user'];
      var phone = response.body[0]['phone'];

      Map<String, dynamic> homeaddress = response.body[0]['homeaddress'];
      if (homeaddress["homeaddress_id"] == '') {
        homeaddress = response.body[0]['homeaddress'];
        homeaddress["homeaddress_id"] = 100000000000000000;
        homeaddress["latitude"] = "13.72917".toString();
        homeaddress["longitude"] = "100.52389".toString();
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
        homeaddress = response.body[0]['homeaddress'];
        print("มี homeaddress_id");
      }

      Map<String, dynamic> officeaddress = response.body[0]['officeaddress'];
      if (officeaddress["officeaddress_id"] == '') {
        officeaddress = response.body[0]['officeaddress'];
        officeaddress["officeaddress_id"] = 100000000000000000;
        officeaddress["latitude"] = "13.72917".toString();
        officeaddress["longitude"] = "100.52389".toString();
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
        officeaddress = response.body[0]['officeaddress'];
        print("มี officeaddress_id");
      }
      print("homeaddress : ${homeaddress}");
      Map<String, dynamic> presentpositionaddress =
          response.body[0]['presentpositionaddress'];
      if (presentpositionaddress["presentpositionaddress_id"] == '') {
        presentpositionaddress = response.body[0]['presentpositionaddress'];
        presentpositionaddress["presentpositionaddress_id"] =
            100000000000000000;
        presentpositionaddress["latitude"] = "13.72917".toString();
        presentpositionaddress["longitude"] = "100.52389".toString();
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
        presentpositionaddress = response.body[0]['presentpositionaddress'];
        print("มี presentpositionaddress_id");
      }
      var order_count;
      if (order_count == '') {
        order_count = 0;

        print("order_count ยังไม่มี");
      } else {
        order_count = response.body[0]['order_count'];
        print("order_count มีแล้ว");
      }

      // print("user : $user");
      // print("phone : $phone");
      // print("latitude : ${latitude}");
      // print("longitude : ${longitude}");
      // print("address : $address");
      // print("order_count : $order_count");

      //เพิ่มข้อมูลเข้าไปใน List
      _profileuserProductList.addAll([
        {'user': user},
        {'phone': phone},
        {'homeaddress': homeaddress},
        {'officeaddress': officeaddress},
        {'presentpositionaddress': presentpositionaddress},
        {'order_count': order_count}
      ]);

      // _profileuserModel = ProfileuserModel.fromJson({
      //   'user': user,
      //   'phone': phone,
      //   'homeaddress': homeaddress,
      //   'officeaddress': officeaddress,
      //   'presentpositionaddress': presentpositionaddress,
      //   'order_count': order_count
      // });
      // print("_profileuserModel :${_profileuserModel}");

      _isLoading = true;
      update();

      print("address :${_profileuserProductList[0]}");

      responseModel = ResponseModel(true, "จัดเรียงข้อมูลสำเร็จ");
      print("true in registration : ${responseModel.message}");
    } else {
      responseModel = ResponseModel(false, "ดึงข้อมูลไม่สำเร็จ");
      print("false in registration : จัดเรียงข้อมูลไม่สำเร็จ");
    }

    return responseModel;
  }

  void SaveAddresstoProfileuser(
    String firstnamecontactController,
    String lastnamecontactController,
    String contactPersonalNumber,
    String addressController,
    AddressModel addressModel,
  ) {
    Map<String, dynamic> user;
    Map<String, dynamic> phone;
    Map<String, dynamic> homeaddress;
    Map<String, dynamic> officeaddress;
    Map<String, dynamic> presentpositionaddress;
    Map<String, dynamic> orderCount;
    ProfileModel _profileModel;

    var locationControllerdata = Get.find<LocationController>()
        .addressTypeList[Get.find<LocationController>().addressTypeIndex];

    var profileUserControllerdata =
        Get.find<ProfileUserController>().profileuserProductList;
    if (locationControllerdata == "home") {
      print(Get.find<ProfileUserController>().profileuserProductList);

      user = profileUserControllerdata[0]["user"];
      print("user in SaveAddresstoProfileuser $user");
      user["firstname"] = firstnamecontactController;
      user["lastname"] = lastnamecontactController;
      print("user in SaveAddresstoProfileuser after edit $user");

      phone = profileUserControllerdata[1];
      phone["phone"] = contactPersonalNumber;
      print("phone : ${phone["phone"]}");

      orderCount = profileUserControllerdata[5];
      print("orderCount :${orderCount}");

      homeaddress = profileUserControllerdata[2]["homeaddress"];

      print("homeaddress in home : ${homeaddress}");

      homeaddress['addressname'] = addressController;
      homeaddress['latitude'] =
          Get.find<LocationController>().position.latitude.toString();
      homeaddress['longitude'] =
          Get.find<LocationController>().position.longitude.toString();
      print("homeaddress in SaveAddresstoProfileuser after edit $homeaddress");

      officeaddress = profileUserControllerdata[3]["officeaddress"];
      officeaddress['latitude'] = officeaddress['latitude'].toString();
      officeaddress['longitude'] = officeaddress['longitude'].toString();
      print("officeaddress in home $officeaddress");
      presentpositionaddress =
          profileUserControllerdata[4]["presentpositionaddress"];
      presentpositionaddress['latitude'] = presentpositionaddress['latitude'];
      presentpositionaddress['longitude'] = presentpositionaddress['longitude'];
      print("presentpositionaddress in home $presentpositionaddress");
      print(homeaddress.runtimeType);

      //ObjectModelsavetoAPI();

      _profileModel = ProfileModel(
        user: UserModel(
            userId: user["user_id"],
            username: user["username"],
            firstname: user["firstname"],
            lastname: user["lastname"],
            email: user["email"]),
        phone: phone["phone"],
        homeaddress: HomeaddressModel(
          homeaddressId: homeaddress["homeaddress_id"],
          latitude: homeaddress["latitude"].toString(),
          longitude: homeaddress["longitude"].toString(),
          addressname: homeaddress["addressname"],
          address: homeaddress["address"],
          tombon: homeaddress["tombon"],
          amphure: homeaddress["amphure"],
          province: homeaddress["province"],
          city: homeaddress["city"],
          zipCode: homeaddress["zip_code"],
          typeId: homeaddress["type_Id"],
        ),
        officeaddress: OfficeaddressModel(
          officeaddressId: officeaddress["officeaddress_id"],
          latitude: officeaddress["latitude"].toString(),
          longitude: officeaddress["longitude"].toString(),
          addressname: officeaddress["addressname"],
          address: officeaddress["address"],
          tombon: officeaddress["tombon"],
          amphure: officeaddress["amphure"],
          province: officeaddress["province"],
          city: officeaddress["city"],
          zipCode: officeaddress["zip_code"],
          typeId: officeaddress["type_Id"],
        ),
        presentpositionaddress: PresentpositionaddressModel(
          presentpositionaddressId:
              presentpositionaddress["presentpositionaddress_id"],
          latitude: presentpositionaddress["latitude"].toString(),
          longitude: presentpositionaddress["longitude"].toString(),
          addressname: presentpositionaddress["addressname"],
          address: presentpositionaddress["address"],
          tombon: presentpositionaddress["tombon"],
          amphure: presentpositionaddress["amphure"],
          province: presentpositionaddress["province"],
          city: presentpositionaddress["city"],
          zipCode: presentpositionaddress["zip_code"],
          typeId: presentpositionaddress["type_Id"],
        ),
        orderCount: orderCount['orderCount'] ?? 0,
        typeId: 4,
      );

      Get.find<LocationController>()
          .addDatatoProfileuser(_profileModel, addressModel)
          .then((responseModel) {
        if (responseModel.isSuccess) {
          Get.back();
          Get.snackbar("บ้านของคุณ", "ถูกบันทึกที่อยู่เรียบร้อยแล้ว",
              backgroundColor: Colors.green.shade700, colorText: Colors.white);
        } else {
          Get.snackbar("บ้านของคุณ", "ไม่สามารถบันทึกที่อยู่ได้ค่ะ",
              backgroundColor: Colors.red.shade600, colorText: Colors.white);
        }
      });
    } else if (locationControllerdata == "office") {
      print(Get.find<ProfileUserController>().profileuserProductList);
      user = profileUserControllerdata[0]["user"];
      print("user in SaveAddresstoProfileuser $user");
      user["firstname"] = firstnamecontactController;
      user["lastname"] = lastnamecontactController;
      print("user in SaveAddresstoProfileuser after edit $user");

      phone = profileUserControllerdata[1];
      phone["phone"] = contactPersonalNumber;
      print("phone : ${phone["phone"]}");

      orderCount = profileUserControllerdata[5];
      print("orderCount :${orderCount}");

      homeaddress = profileUserControllerdata[2]["homeaddress"];
      homeaddress['latitude'] = homeaddress['latitude'].toString();
      homeaddress['longitude'] = homeaddress['longitude'].toString();
      print("homeaddress in  in office  $homeaddress");
      officeaddress = profileUserControllerdata[3]["officeaddress"];
      print("officeaddress  in office  $officeaddress");

      officeaddress['addressname'] = addressController;
      officeaddress['latitude'] =
          Get.find<LocationController>().position.latitude.toString();
      officeaddress['longitude'] =
          Get.find<LocationController>().position.longitude.toString();

      print(
          "officeaddress in SaveAddresstoProfileuser in office $officeaddress");
      presentpositionaddress =
          profileUserControllerdata[4]["presentpositionaddress"];
      presentpositionaddress['latitude'] = presentpositionaddress['latitude'];
      presentpositionaddress['longitude'] = presentpositionaddress['longitude'];
      print("presentpositionaddress in office $presentpositionaddress");
      print(homeaddress.runtimeType);
      _profileModel = ProfileModel(
        user: UserModel(
            userId: user["user_id"],
            username: user["username"],
            firstname: user["firstname"],
            lastname: user["lastname"],
            email: user["email"]),
        phone: phone["phone"],
        homeaddress: HomeaddressModel(
          homeaddressId: homeaddress["homeaddress_id"],
          latitude: homeaddress["latitude"].toString(),
          longitude: homeaddress["longitude"].toString(),
          addressname: homeaddress["addressname"],
          address: homeaddress["address"],
          tombon: homeaddress["tombon"],
          amphure: homeaddress["amphure"],
          province: homeaddress["province"],
          city: homeaddress["city"],
          zipCode: homeaddress["zip_code"],
          typeId: homeaddress["type_Id"],
        ),
        officeaddress: OfficeaddressModel(
          officeaddressId: officeaddress["officeaddress_id"],
          latitude: officeaddress["latitude"].toString(),
          longitude: officeaddress["longitude"].toString(),
          addressname: officeaddress["addressname"],
          address: officeaddress["address"],
          tombon: homeaddress["tombon"],
          amphure: officeaddress["amphure"],
          province: homeaddress["province"],
          city: officeaddress["city"],
          zipCode: officeaddress["zip_code"],
          typeId: officeaddress["type_Id"],
        ),
        presentpositionaddress: PresentpositionaddressModel(
          presentpositionaddressId:
              presentpositionaddress["presentpositionaddress_id"],
          latitude: presentpositionaddress["latitude"].toString(),
          longitude: presentpositionaddress["longitude"].toString(),
          addressname: presentpositionaddress["addressname"],
          address: presentpositionaddress["address"],
          tombon: presentpositionaddress["tombon"],
          amphure: presentpositionaddress["amphure"],
          province: presentpositionaddress["province"],
          city: presentpositionaddress["city"],
          zipCode: presentpositionaddress["zip_code"],
          typeId: presentpositionaddress["type_Id"],
        ),
        orderCount: orderCount['orderCount'] ?? 0,
        typeId: 4,
      );

      Get.find<LocationController>()
          .addDatatoProfileuser(_profileModel, addressModel)
          .then((responseModel) {
        if (responseModel.isSuccess) {
          Get.back();
          Get.snackbar("ที่ทำงาน", "ถูกบันทึกที่อยู่เรียบร้อยแล้ว",
              backgroundColor: Colors.green.shade700, colorText: Colors.white);
        } else {
          Get.snackbar("ที่ทำงาน", "ไม่สามารถบันทึกที่อยู่ได้ค่ะ",
              backgroundColor: Colors.red.shade600, colorText: Colors.white);
        }
      });
    } else if (locationControllerdata == "other") {
      print(Get.find<ProfileUserController>().profileuserProductList);
      user = profileUserControllerdata[0]["user"];
      print("user in SaveAddresstoProfileuser $user");
      user["firstname"] = firstnamecontactController;
      user["lastname"] = lastnamecontactController;
      print("user in SaveAddresstoProfileuser after edit $user");

      phone = profileUserControllerdata[1];
      phone["phone"] = contactPersonalNumber;
      print("phone : ${phone["phone"]}");

      orderCount = profileUserControllerdata[5];
      print("orderCount :${orderCount}");

      homeaddress = profileUserControllerdata[2]["homeaddress"];
      homeaddress['latitude'] = homeaddress['latitude'].toString();
      homeaddress['longitude'] = homeaddress['longitude'].toString();
      print("homeaddress in  in other  $homeaddress");
      officeaddress = profileUserControllerdata[3]["officeaddress"];
      officeaddress['latitude'] = officeaddress['latitude'].toString();
      officeaddress['longitude'] = officeaddress['longitude'].toString();
      print("officeaddress  in other  $officeaddress");

      presentpositionaddress =
          profileUserControllerdata[4]["presentpositionaddress"];
      print("presentpositionaddress in other $presentpositionaddress");
      presentpositionaddress['addressname'] = addressController;
      presentpositionaddress['latitude'] =
          Get.find<LocationController>().position.latitude.toString();
      presentpositionaddress['longitude'] =
          Get.find<LocationController>().position.longitude.toString();

      print(
          "presentpositionaddress in SaveAddresstoProfileuser in other $presentpositionaddress");
      _profileModel = ProfileModel(
        user: UserModel(
            userId: user["user_id"],
            username: user["username"],
            firstname: user["firstname"],
            lastname: user["lastname"],
            email: user["email"]),
        phone: phone["phone"],
        homeaddress: HomeaddressModel(
          homeaddressId: homeaddress["homeaddress_id"],
          latitude: homeaddress["latitude"].toString(),
          longitude: homeaddress["longitude"].toString(),
          addressname: homeaddress["addressname"],
          address: homeaddress["address"],
          tombon: homeaddress["tombon"],
          amphure: homeaddress["amphure"],
          province: homeaddress["province"],
          city: homeaddress["city"],
          zipCode: homeaddress["zip_code"],
          typeId: homeaddress["type_Id"],
        ),
        officeaddress: OfficeaddressModel(
          officeaddressId: officeaddress["officeaddress_id"],
          latitude: officeaddress["latitude"].toString(),
          longitude: officeaddress["longitude"].toString(),
          addressname: officeaddress["addressname"],
          address: officeaddress["address"],
          tombon: officeaddress["tombon"],
          amphure: officeaddress["amphure"],
          province: officeaddress["province"],
          city: officeaddress["city"],
          zipCode: officeaddress["zip_code"],
          typeId: officeaddress["type_Id"],
        ),
        presentpositionaddress: PresentpositionaddressModel(
          presentpositionaddressId:
              presentpositionaddress["presentpositionaddress_id"],
          latitude: presentpositionaddress["latitude"].toString(),
          longitude: homeaddress["longitude"].toString(),
          addressname: presentpositionaddress["addressname"],
          address: presentpositionaddress["address"],
          tombon: presentpositionaddress["tombon"],
          amphure: presentpositionaddress["amphure"],
          province: presentpositionaddress["province"],
          city: presentpositionaddress["city"],
          zipCode: presentpositionaddress["zip_code"],
          typeId: presentpositionaddress["type_Id"],
        ),
        orderCount: orderCount['orderCount'] ?? 0,
        typeId: 4,
      );

      Get.find<LocationController>()
          .addDatatoProfileuser(_profileModel, addressModel)
          .then((response) {
        if (response.isSuccess) {
          Get.back();
          Get.snackbar("ตำแหน่งปัจจุบันของคุณ", "ถูกบันทึกที่อยู่เรียบร้อยแล้ว",
              backgroundColor: Colors.green.shade700, colorText: Colors.white);
        } else {
          Get.snackbar("ตำแหน่งปัจจุบันของคุณ", "ไม่สามารถบันทึกที่อยู่ได้ค่ะ",
              backgroundColor: Colors.red.shade600, colorText: Colors.white);
        }
      });
    }
  }
}
