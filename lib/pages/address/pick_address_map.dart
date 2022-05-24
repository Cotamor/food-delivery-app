import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/base/custom_button.dart';
import 'package:food_deli/controllers/location_controller.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/app_text_field.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  // final LatLng latlng;
  const PickAddressMap({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    // this.latlng = const LatLng(45.521563, -122.677433),
    this.googleMapController,
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
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
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 17,
                  ),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    locationController.updatePosition(_cameraPosition, false);
                  },
                ),
                Center(
                    child: !locationController.loading
                        ? Image.asset(
                            'assets/image/pick_marker.png',
                            width: Dimentions.width100 / 2,
                            height: Dimentions.height100 / 2,
                          )
                        : const CircularProgressIndicator()),
                Positioned(
                  top: Dimentions.height45,
                  right: Dimentions.width20,
                  left: Dimentions.width20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimentions.width10),
                    height: Dimentions.height100 / 2,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(Dimentions.radius20 / 2),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.yellowColor,
                        ),
                        Expanded(
                          child: Text(
                            '${locationController.pickPlacemark.name}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimentions.font16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: Dimentions.width20,
                  left: Dimentions.width20,
                  child: locationController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          buttonText: locationController.inZone
                              ? widget.fromAddress
                                  ? 'Pick Address'
                                  : 'Pick Location'
                              : 'Service is not available in this area',
                          onPressed: locationController.buttonDisabled || locationController.loading
                              ? null
                              : () {
                                  if (locationController.pickPosition.latitude != 0 &&
                                      locationController.pickPlacemark.name != null) {
                                    if (widget.fromAddress) {
                                      if (widget.googleMapController != null) {
                                        print('Now you have clicked on this');
                                        widget.googleMapController!.moveCamera(
                                          CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                              target: LatLng(
                                                locationController.pickPosition.latitude,
                                                locationController.pickPosition.longitude,
                                              ),
                                            ),
                                          ),
                                        );
                                        locationController.setAddAddressData();
                                      }
                                      // Get.back() create update problem
                                      Get.back();
                                      // list, a value
                                      // Get.toNamed(RouteHelper.getAddAddressPage());
                                    }
                                  }
                                },
                        ),
                ),
              ],
            ),
          ),
        )),
      );
    });
  }
}
