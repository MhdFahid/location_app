import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_app/const/app_color_constants.dart';
import 'package:location_app/view/widgets/button_login_and_sign_in.dart';
import 'package:location_app/view/widgets/input_text_field.dart';
import '../../controllers/auth_controller.dart';
import 'social_login_button.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Unified validation function
  String? validateInput(String? value, String inputType) {
    if (value == null || value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your $inputType',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }

    if (inputType == 'email' && !GetUtils.isEmail(value)) {
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
  }

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/service_connect.png',
                  width: size.width * 0.8,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Let's Log In.!",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColorsConstants.headingTextBlue),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Login to Your Account to Continue your Courses",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColorsConstants.textColor),
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
                validator: (value) => validateInput(value, 'email'),
              ),
              const SizedBox(
                height: 30,
              ),
              InputTextField(
                controller: passwordController,
                labelText: 'Password',
                isPasswordVisible: authController.isPasswordVisible,
                prefixIcon: Icons.lock_outlined,
                validator: (value) => validateInput(value, 'password'),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 30),
              Obx(
                () => ButtonLoginAndSignIn(
                  size: size,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authController.login(
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                  title: 'Log In',
                  isLoading: authController.isLoading.value,
                ),
              ),
              const SizedBox(height: 30),
              Text('Or Continue With',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColorsConstants.textColor)),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SocialLoginIcon(iconPath: 'assets/icons/google.png'),
                  SizedBox(width: size.width * 0.1),
                  const SocialLoginIcon(iconPath: 'assets/icons/apple.png'),
                ],
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => Get.toNamed('/signup'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account? ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColorsConstants.textColor)),
                    Text("Sign Up",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColorsConstants.textColor)),
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
