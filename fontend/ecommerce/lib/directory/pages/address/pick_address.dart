import 'package:ecommerce/controllers/location_controller.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressPage extends StatefulWidget {
  final bool fromSignup;
  final bool fromaddress;
  final GoogleMapController? googleMapController;
  const PickAddressPage(
      {Key? key,
      required this.fromSignup,
      required this.fromaddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressPage> createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
  late LatLng _initailPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initailPosition = LatLng(16.119, 101.895);
      _cameraPosition = CameraPosition(target: _initailPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initailPosition = LatLng(
            double.parse(
              Get.find<LocationController>().getAddress["latitude"],
            ),
            double.parse(
              Get.find<LocationController>().getAddress["longitude"],
            ));
        _cameraPosition = CameraPosition(target: _initailPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
          body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initailPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
                  },
                ),
                Center(
                  child: !locationController.loading
                      ? Image.asset(
                          "assets/image_ui/location.png",
                          height: DimensionStaticHeight(context, 50),
                          width: DimensionStaticWidth(context, 50),
                        )
                      : const CircularProgressIndicator(),
                ),
                Positioned(
                  top: DimensionStaticHeight(context, 45),
                  left: DimensionStaticWidth(context, 20),
                  right: DimensionStaticWidth(context, 20),
                  child: Container(
                    height: DimensionStaticHeight(context, 50),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(
                        DimensionStaticHeight(context, 10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: DimensionStaticWidth(context, 10),
                              right: DimensionStaticWidth(context, 10)),
                          child: Icon(
                            Icons.location_on,
                            size: DimensionStaticHeight(context, 25),
                            color: Colors.yellowAccent,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${locationController.pickPlacemark.name ?? ''}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    });
  }
}
