import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/location_controller.dart';
import 'package:ecommerce/controllers/profile_controlle.dart';
import 'package:ecommerce/directory/pages/address/address_widget.dart';
import 'package:ecommerce/directory/pages/address/pick_address.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_widget.dart';
import 'package:ecommerce/directory/pages/sign_up/sign_up_width.dart';
import 'package:ecommerce/model/address_model.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();

  final TextEditingController _contactPersonalNumber = TextEditingController();
  final TextEditingController _firstnamecontactController =
      TextEditingController();
  final TextEditingController _lastnamecontactController =
      TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(16.119, 101.895), zoom: 17);

  LatLng _initialPosition = LatLng(16.119, 101.895);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged &&
        Get.find<ProfileUserController>().profileuserProductList.isEmpty) {
      print("ทำgetProfileUserList()");
      Get.find<ProfileUserController>().getProfileUserList();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      print("addressList ไม่เป็น ลิสต์ว่าง");
      if (Get.find<LocationController>().getAddressFromLocalStorage() == "") {
        // Get.find<LocationController>().adduseraddress(Get.find<LocationController>().addressList.last)
      }
      Get.find<LocationController>().getUserAddress();
      print("Get.find<LocationController>().getAddress");

      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Address page"),
          ],
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<ProfileUserController>(builder: (profilecontroller) {
        if (profilecontroller.profileuserProductList.isNotEmpty &
            _firstnamecontactController.text.isEmpty) {
          print("profilecontroller in AddAddressPage${profilecontroller}");
          var datacontroller = profilecontroller.profileuserProductList;

          var usercontroller =
              profilecontroller.profileuserProductList[0]["user"];
          _firstnamecontactController.text = usercontroller["firstname"];
          _lastnamecontactController.text = usercontroller["lastname"];
          _contactPersonalNumber.text = datacontroller[1]["phone"];
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationController>().getAddress["address"];
            print(_addressController.text);
            print("addressList.isNotEmpty");
          }
        }
        return GetBuilder<LocationController>(builder: (locationcontroller) {
          print(
              "locationcontroller.placemark :${locationcontroller.placemark}");
          _addressController.text = '${locationcontroller.placemark.name ?? ''}'
              '${locationcontroller.placemark.locality ?? ''}'
              '${locationcontroller.placemark.postalCode ?? ''}'
              '${locationcontroller.placemark.country ?? ''}';
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 2, color: Theme.of(context).primaryColor)),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 17,
                        ),
                        onTap: (latlng) {
                          Get.toNamed(RounteHelper.getpickAddressPage(),
                              arguments: PickAddressPage(
                                fromSignup: false,
                                fromaddress: true,
                                googleMapController:
                                    locationcontroller.mapController,
                              ));
                        },
                        zoomControlsEnabled: false,
                        myLocationEnabled: true,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        onCameraIdle: () {
                          locationcontroller.updatePosition(
                              _cameraPosition, true);
                        },
                        onCameraMove: ((position) =>
                            _cameraPosition = position),
                        onMapCreated: (GoogleMapController controller) {
                          locationcontroller.setMapController(controller);
                          if (Get.find<LocationController>()
                              .addressList
                              .isEmpty) {
//locationcontroller.getCurrentLocation(true,GoogleMapController);
                          }
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: DimensionStaticWidth(context, 20),
                      top: DimensionStaticHeight(context, 20)),
                  child: SizedBox(
                    height: DimensionStaticHeight(context, 50),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationcontroller.addressTypeList.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              locationcontroller.setAddressTypeIndex(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      DimensionStaticHeight(context, 20),
                                  vertical: DimensionStaticWidth(context, 10)),
                              margin: EdgeInsets.only(
                                right: DimensionStaticWidth(context, 10),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    DimensionStaticHeight(context, 20 / 4),
                                  ),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 1,
                                        blurRadius: 5)
                                  ]),
                              child: Icon(
                                index == 0
                                    ? Icons.home_filled
                                    : index == 1
                                        ? Icons.work
                                        : Icons.location_on,
                                color:
                                    locationcontroller.addressTypeIndex == index
                                        ? AppColors.mainColor
                                        : Theme.of(context).disabledColor,
                              ),
                            ),
                          );
                        })),
                  ),
                ),
                DimensionheightWidget(context, 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: DimensionStaticWidth(context, 20),
                  ),
                  child: BigText(
                    text: "ที่อยู่ในการจัดส่ง",
                    size: DimensionStaticHeight(context, 16),
                  ),
                ),
                DimensionheightWidget(context, 10),
                AddressWidget(
                  height: 110,
                  texteditingcontroller: _addressController,
                  hinttext: "ที่อยู่ของคุณ",
                  Icontext: Icons.map_outlined,
                ),
                DimensionheightWidget(context, 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: DimensionStaticWidth(context, 20),
                  ),
                  child: BigText(
                    text: "ชื่อผู้รับสินค้า",
                    size: DimensionStaticHeight(context, 16),
                  ),
                ),
                DimensionheightWidget(context, 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: DimensionStaticWidth(context, 45),
                    right: DimensionStaticWidth(context, 45),
                  ),
                  child: Row(
                    children: [
                      SignUpWidth(
                        texteditingcontroller: _firstnamecontactController,
                        hinttext: "First name",
                        Icontext: Icons.person_outline_outlined,
                      ),
                      DimensionwidthWidget(context, 10),
                      SignUpWidth(
                        texteditingcontroller: _lastnamecontactController,
                        hinttext: "Last name",
                        Icontext: Icons.groups_outlined,
                      ),
                    ],
                  ),
                ),
                DimensionheightWidget(context, 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: DimensionStaticWidth(context, 20),
                  ),
                  child: BigText(
                    text: "เบอร์โทรศัพท์ของผู้รับสินค้า",
                    size: DimensionStaticHeight(context, 16),
                  ),
                ),
                DimensionheightWidget(context, 10),
                SignUpWidget(
                  texteditingcontroller: _contactPersonalNumber,
                  hinttext: "เบอร์โทรศัพท์",
                  Icontext: Icons.mobile_friendly_outlined,
                ),
                DimensionheightWidget(context, 10),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar:
          GetBuilder<LocationController>(builder: (locationcontroller) {
        //print("controller.inCartItems : ${controller.inCartItems}");
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: DimensionStaticHeight(context, 90),
              decoration: BoxDecoration(
                color: AppColors.buttonbackgroungColor,
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(DimensionStaticHeight(context, 20 * 2)),
                  topRight:
                      Radius.circular(DimensionStaticHeight(context, 20 * 2)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      AddressModel addressModel = AddressModel(
                        addressType: locationcontroller.addressTypeList[
                            locationcontroller.addressTypeIndex],
                        contactPersonalName:
                            "${_firstnamecontactController.text} ${_lastnamecontactController.text}",
                        contactPersonalNumber: _contactPersonalNumber.text,
                        address: _addressController.text,
                        latitude:
                            locationcontroller.position.latitude.toString(),
                        longitude:
                            locationcontroller.position.longitude.toString(),
                      );
                      Get.find<ProfileUserController>()
                          .SaveAddresstoProfileuser(
                              _firstnamecontactController.text,
                              _lastnamecontactController.text,
                              _contactPersonalNumber.text,
                              _addressController.text,
                              addressModel);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: DimensionStaticWidth(context, 25),
                      ),
                      padding: EdgeInsets.only(
                          top: DimensionStaticHeight(context, 20),
                          bottom: DimensionStaticHeight(context, 20),
                          left: DimensionStaticWidth(context, 20),
                          right: DimensionStaticWidth(context, 20)),
                      // ignore: sort_child_properties_last
                      child: BigText(
                        text: "บันทึกข้อมูล",
                        color: Colors.white,
                        size: DimensionStaticHeight(context, 15),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              DimensionStaticHeight(context, 20)),
                          color: AppColors.mainColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
