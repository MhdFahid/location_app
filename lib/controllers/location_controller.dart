import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  var latitude = ''.obs;
  var longitude = ''.obs;
  var locationStatus = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationStatus.value = "Location permission denied";
          Get.snackbar("Permission Error", "Location permission denied",
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationStatus.value = "Location permission permanently denied";
        Get.snackbar("Permission Error",
            "Location permission permanently denied. Please enable it in app settings.",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
            mainButton: TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: const Text(" Settings"),
            ));
        return;
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        latitude.value = position.latitude.toString();
        longitude.value = position.longitude.toString();
        locationStatus.value = "Location fetched successfully";
      } else {
        locationStatus.value = "Permission error";
        Get.snackbar("Permission Error",
            "Unable to fetch location. Permission required.",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      locationStatus.value = "Error fetching location";
      Get.snackbar("Location Error", "Error fetching location: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
