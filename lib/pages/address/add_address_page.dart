import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/base/show_custom_snackbar.dart';
import 'package:food_deli/controllers/auth_controller.dart';
import 'package:food_deli/controllers/location_controller.dart';
import 'package:food_deli/controllers/user_controller.dart';
import 'package:food_deli/models/address_model.dart';
import 'package:food_deli/pages/address/pick_address_map.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/app_text_field.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(45.51563, -122.677433),
    zoom: 17,
  );
  late LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(45.521563, -122.677433);
    } else {
      // bug fix
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() == '') {
        Get.find<LocationController>().saveUserAddress(
          Get.find<LocationController>().addressList.last,
        );
      }

      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Page'),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null && _contactPersonName.text.isEmpty) {
            _contactPersonName.text = userController.userModel!.name;
            _contactPersonNumber.text = userController.userModel!.phone;
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              // ...
              _addressController.text = Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(builder: (locationController) {
            _addressController.text = '${locationController.placemark.name ?? ''}'
                '${locationController.placemark.locality ?? ''}'
                '${locationController.placemark.postalCode ?? ''}'
                '${locationController.placemark.country ?? ''}';
            print('Address in my view: ${_addressController.text}');
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: AppColors.mainColor,
                      ),
                    ),
                    child: Stack(
                      children: [
                        GoogleMap(
                          onTap: (latlug) {
                            Get.toNamed(
                              RouteHelper.getPickAddressPage(),
                              arguments: PickAddressMap(
                                fromSignup: false,
                                fromAddress: true,
                                googleMapController: locationController.mapController,
                              ),
                            );
                          },
                          initialCameraPosition: CameraPosition(
                            target: _initialPosition,
                            zoom: 17,
                          ),
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          // When you move around the map with the mouse, this function get called
                          onCameraIdle: () {
                            locationController.updatePosition(_cameraPosition, true);
                          },
                          onCameraMove: (position) => _cameraPosition = position,
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setMapController(controller);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height100 / 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            locationController.setAddressTypeIndex(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: Dimentions.width20),
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimentions.width20, vertical: Dimentions.height10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimentions.radius20 / 4),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  index == 0
                                      ? Icons.home_filled
                                      : index == 1
                                          ? Icons.work
                                          : Icons.location_on,
                                  color: locationController.addressTypeIndex == index
                                      ? AppColors.mainColor
                                      : Theme.of(context).disabledColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: Dimentions.height20),
                  Padding(
                    padding: EdgeInsets.only(left: Dimentions.width20),
                    child: const LargeText(text: 'Delivery Address'),
                  ),
                  SizedBox(height: Dimentions.height20),
                  AppTextField(controller: _addressController, hintText: 'Your address', icon: Icons.place_outlined),
                  SizedBox(height: Dimentions.height20),
                  Padding(
                    padding: EdgeInsets.only(left: Dimentions.width20),
                    child: const LargeText(text: 'Contact name'),
                  ),
                  SizedBox(height: Dimentions.height10),
                  AppTextField(controller: _contactPersonName, hintText: 'Your name', icon: Icons.person),
                  SizedBox(height: Dimentions.height20),
                  Padding(
                    padding: EdgeInsets.only(left: Dimentions.width20),
                    child: const LargeText(text: 'Your number'),
                  ),
                  SizedBox(height: Dimentions.height10),
                  AppTextField(controller: _contactPersonNumber, hintText: 'Your phone', icon: Icons.phone),
                ],
              ),
            );
          });
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimentions.bottomHeightBar120,
                padding: EdgeInsets.only(
                  top: Dimentions.height30,
                  bottom: Dimentions.height30,
                  left: Dimentions.width20,
                  right: Dimentions.width20,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20),
                    topRight: Radius.circular(Dimentions.radius20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Bottom Nav(Save address)
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude: locationController.position.latitude.toString(),
                          longitude: locationController.position.longitude.toString(),
                        );
                        locationController.addAddress(_addressModel).then((value) {
                          if (value.isSuccess) {
                            Get.toNamed(RouteHelper.getInitial());
                            showCustomSnackBar('Added Successfully', title: 'Address', color: Colors.green);
                          } else {
                            showCustomSnackBar(
                              'Failed to add',
                              title: 'Address',
                            );
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimentions.width20, vertical: Dimentions.height20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: const LargeText(
                          text: 'Save Address',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
