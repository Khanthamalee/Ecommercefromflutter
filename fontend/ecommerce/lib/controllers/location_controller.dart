import 'dart:convert';
import 'package:ecommerce/data/repository/location_repo.dart';
import 'package:ecommerce/model/address_model.dart';
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
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
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

  List<dynamic> _getAddressList = [];
  List<dynamic> get getAddressList => _getAddressList;

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

  // Future<ResponseModel> getAddressfromGeocode(LatLng latLng) async {
  //   String _address = "ไม่พบที่อยู่ของคุณ";
  //   Response response = await locationRepo.getAddressfromGeocode(latLng);

  //   //print(response.statusCode);
  //   late ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     _getAddressList = [];
  //     var latitude = response.body['latitude'];
  //     var longitude = response.body['longitude'];
  //     var fulladdress = response.body['full_address'];
  //     var address = response.body['address'];
  //     var tambon = response.body['tambon'];
  //     var distric = response.body['distric'];
  //     var province = response.body['province'];
  //     var city = response.body['city'];

  //     String _address = fulladdress;

  //     _getAddressList.addAll({
  //       {'latitude': latitude},
  //       {'longitude': longitude},
  //       {'fulladdress': fulladdress},
  //       {'address': address},
  //       {'tambon': tambon},
  //       {'distric': distric},
  //       {'province': province},
  //       {'city': city}
  //     });
  //     //update();
  //     print(_getAddressList);
  //     print("จัดเรียงข้อมูลที่อยู่เรียบร้อยแล้ว");
  //     responseModel = ResponseModel(true, "$_address");
  //     //_address = response.body['full_address'].toString();
  //     //print("full_address : ${response.body['full_address'].toString()}");
  //   } else {
  //     print("Error getting the google API");
  //     responseModel = ResponseModel(false, "ดึงข้อมูลไม่สำเร็จ");
  //   }
  //   update();
  //   return responseModel;
  // }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    print("_getAddress : ${_getAddress}");
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
      print("_addressModel : ${_addressModel.address}");
    } catch (e) {
      print("e in getUserAddress :${e}");
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }
}
