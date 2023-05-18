import 'dart:convert';
import 'package:ecommerce/data/repository/location_repo.dart';
import 'package:ecommerce/model/address_model.dart';
import 'package:ecommerce/model/profile_model.dart';
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
  List<ProfileModel> _addressList = [];
  List<ProfileModel> get addressList => _addressList;
  late List<ProfileModel> _allAddressList;
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
      print("printing address $_address");
    } else {
      print("ไม่สามารถเชื่อต่อ API ได้");
    }
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  ProfileModel getUserAddress() {
    late ProfileModel _profileModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    print("_getAddress in getUserAddress : ${_getAddress}");
    try {
      _profileModel =
          ProfileModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
      _addressList.addAll({_profileModel!.homeaddress!["addressname"]});
      print("_profileModel in getUserAddress : ${_profileModel.user}");
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

  Future<ResponseModel> addDatatoProfileuser(ProfileModel profileModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addDatatoProfileuser(profileModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      print(response.body);
      String message = response.body["msg"];
      responseModel = ResponseModel(true, message);
      print("message");
    } else {
      print("ไม่สามารถบันทึกข้อมูลได้ค่ะ");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}
