import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_app/const/app_color_constants.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final RxBool isPasswordVisible;
  final IconData prefixIcon;
  final String? Function(String?)? validator;

  const InputTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.isPasswordVisible,
    required this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(216, 5, 5, 5).withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: AppColorsConstants.textFieldBackgroundColor,
                borderRadius: BorderRadius.circular(15)),
            child: TextFormField(
              controller: controller,
              obscureText: !isPasswordVisible.value,
              style: TextStyle(
                color: AppColorsConstants.whiteTextColor,
              ),
              decoration: InputDecoration(
                hintText: labelText,
                hintStyle: TextStyle(
                    color: AppColorsConstants.whiteTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
                prefixIcon: Icon(
                  prefixIcon,
                  color: AppColorsConstants.whiteTextColor,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColorsConstants.whiteTextColor,
                  ),
                  onPressed: () {
                    isPasswordVisible.value = !isPasswordVisible.value;
                  },
                ),
              ),
              validator: validator,
            ),
          ),
        ));
  }
}
