import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/app_color_constants.dart';

class LogoutPopup extends StatelessWidget {
  const LogoutPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(
              height: 2,
              width: double.infinity,
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Are you sure you want to Logout?",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Not now',
                      style: TextStyle(
                          color: AppColorsConstants.blueButtonColor,
                          fontSize: 14),
                    ),
                  ),
                ),
                // gapw(6),
                MaterialButton(
                  color: AppColorsConstants.redColor,
                  splashColor: AppColorsConstants.redColor,
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAllNamed('/login');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
