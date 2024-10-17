import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../const/app_color_constants.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../login/logout_popup.dart';
import 'logout_button.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final LocationController locationController = Get.put(LocationController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColorsConstants.scafoldColor,
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(),
              child: InkWell(
                  onTap: () async {
                    Get.dialog(
                      const LogoutPopup(),
                    );
                  },
                  child: const LogoutButton()),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username: ${_auth.currentUser?.email ?? ''}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColorsConstants.headingTextBlue),
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (locationController.latitude.isNotEmpty &&
                  locationController.longitude.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 64, 86, 252),
                      height: size.height * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              double.parse(locationController.latitude.value),
                              double.parse(locationController.longitude.value),
                            ),
                            initialZoom: 13.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(
                                    double.parse(
                                        locationController.latitude.value),
                                    double.parse(
                                        locationController.longitude.value),
                                  ),
                                  child: const Icon(Icons.location_pin,
                                      color: Color.fromARGB(255, 115, 0, 0),
                                      size: 40),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Latitude: ${locationController.latitude}',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColorsConstants.headingTextBlue),
                    ),
                    Text(
                      'Longitude: ${locationController.longitude}',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColorsConstants.headingTextBlue),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Text(locationController.locationStatus.value),
                    const SizedBox(height: 20),
                    locationController.isLoading.value
                        ? Center(
                            child: CupertinoActivityIndicator(
                            color: AppColorsConstants.blueButtonColor,
                          ))
                        : ElevatedButton(
                            onPressed: () async {
                              await locationController.getCurrentLocation();
                            },
                            child: Text(
                              locationController.locationStatus.value ==
                                      "Location permission denied"
                                  ? 'Request Permission Again'
                                  : 'Fetch Location',
                            ),
                          ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
