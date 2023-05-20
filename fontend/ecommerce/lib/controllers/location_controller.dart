import 'dart:convert';
import 'package:ecommerce/data/repository/location_repo.dart';
import 'package:ecommerce/model/Profileusermodel.dart';
import 'package:ecommerce/model/address_model.dart';
import 'package:ecommerce/model/positiontoMapModel.dart';
import 'package:ecommerce/model/profile_stringModel.dart';
import 'package:ecommerce/model/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickplacemark => _pickPlacemark;
  List<ProfileuserModel> _addressList = [];
  List<ProfileuserModel> get addressList => _addressList;
  late List<ProfileuserModel> _allAddressList;
  List<ProfileuserModel> get allAddressList => _allAddressList;
  final List<String> _addressTypeList = ["home", "office", "other"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        } else {
          _pickPosition = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        }
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(LatLng(
            position.target.latitude,
            position.target.longitude,
          ));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latlng) async {
    String _address = "ไม่พบที่อยู่ของคุณ";
    Response response = await locationRepo.getAddressfromGeocode(latlng);
    if (response.statusCode == 200) {
      _address =
          response.body["fulladdress"][0]['formatted_address'].toString();
      print(response.body["fulladdress"][0]['formatted_address'].runtimeType);
      print(response.body);
      print("printing address $_address");
    } else {
      print("ไม่สามารถเชื่อต่อ API ได้");
    }
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;
  ProfileModel getUserAddress() {
    late ProfileModel _profileModel;
    print("locationRepo.getUserAddress() is ");
    print("jsonEncode(locationRepo.getUserAddress())");
    print(jsonDecode(locationRepo.getUserAddress()));
    _getAddress = jsonDecode(locationRepo.getUserAddress());

    print("_getAddress['latitude'] :${_getAddress["latitude"]}");

    try {
      _profileModel =
          ProfileModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
      print("_profileModel");
      print(_profileModel);
    } catch (e) {
      print("e in getUserAddress :${e}");
    }
    return _profileModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  List<dynamic> _getAddressList = [];
  List<dynamic> get getAddressList => _getAddressList;

  Future<ResponseModel> addDatatoProfileuser(
      ProfileModel profileModel, AddressModel addressModel) async {
    _loading = true;
    update();
    print(
        "profileuserModel.toJson() in addDatatoProfileuser  : ${profileModel.toJson()}");
    Response response = await locationRepo.addDatatoProfileuser(profileModel);
    print("addDatatoProfileuser");
    print("response.statusCode in addDatatoProfileuser${response.statusCode}");
    print("response.body in addDatatoProfileuser${response.body}");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      getaddressList();
      print("response.body in addDatatoProfileuser : ${response.body}");

      String message = response.body["msg"].toString();
      responseModel = ResponseModel(true, message);

      print(message);
      await adduseraddress(addressModel);
    } else {
      print("ไม่สามารถบันทึกข้อมูลได้ค่ะ");
      print(response.body);
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> getaddressList() async {
    Response response = await locationRepo.getProfileUserList();
    print("response.body in getaddressList : ${response.body} ");
    print(
        "response.body.RuntimeType in getaddressList : ${response.body.runtimeType} ");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];

      response.body.forEach((element) {
        print("element in getaddressList locationController ");
        print(element);
        _addressList.add(ProfileuserModel.fromJson(element));
        _allAddressList.add(ProfileuserModel.fromJson(element));

        print("_addressList : ${_addressList}");
        print("_allAddressList : ${_allAddressList}");
      });

      responseModel =
          ResponseModel(true, "มี _addressList และ _allAddressList");
    } else {
      _addressList = [];
      _allAddressList = [];
      responseModel = ResponseModel(false, "${response.statusCode}");
    }

    update();
    return responseModel;
  }

  Future<bool> adduseraddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.adduseraddress(userAddress);
  }
}
