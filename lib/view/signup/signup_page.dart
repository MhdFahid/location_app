import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_app/const/app_color_constants.dart';
import 'package:location_app/view/widgets/button_login_and_sign_in.dart';
import 'package:location_app/view/widgets/input_text_field.dart';
import '../../controllers/auth_controller.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColorsConstants.scafoldColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.08,
              ),
              Image.asset(
                'assets/images/service_connect.png',
                width: size.width * 0.8,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Let's Sign Up.!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColorsConstants.headingTextBlue,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Create an account to get started with your journey.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColorsConstants.textColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              InputTextField(
                controller: emailController,
                labelText: 'Email',
                isPasswordVisible: authController.isEmailVisible,
                prefixIcon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please enter your email',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return null; // To stop further validation
                  }
                  if (!GetUtils.isEmail(value)) {
                    Get.snackbar(
                      'Error',
                      'Please enter a valid email',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return null;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              InputTextField(
                controller: passwordController,
                labelText: 'Password',
                isPasswordVisible: authController.isPasswordVisible,
                prefixIcon: Icons.lock_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please enter your password',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return null; // Prevent further validation
                  }
                  return null; // No error
                },
              ),
              const SizedBox(height: 30),
              InputTextField(
                controller: confirmPasswordController,
                labelText: 'Confirm Password',
                isPasswordVisible: authController.isConfirmPasswordVisible,
                prefixIcon: Icons.lock_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Obx(
                () => ButtonLoginAndSignIn(
                  size: size,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authController.signUp(
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                  title: 'Sign Up',
                  isLoading: authController.isLoading.value,
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => Get.toNamed('/login'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColorsConstants.textColor,
                      ),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColorsConstants.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
