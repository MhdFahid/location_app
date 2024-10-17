import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = Rx<User?>(null);

  @override
  void onInit() {
    loadUserData();
    listenToAuthState();
    super.onInit();
  }

  var isLoading = false.obs;

  var isEmailVisible = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleEmailVisibility() {
    isEmailVisible.value = !isEmailVisible.value;
  }

  Future<void> checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn && _auth.currentUser != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.offAllNamed('/home');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Login Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      isLoading.value = false;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.offAllNamed('/home');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Signup Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> saveUserData(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user?.uid ?? '');
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    if (userId != null) {
      user.value = FirebaseAuth.instance.currentUser;
    }
  }

  void listenToAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user.value = user;
      if (user == null) {
        Get.offNamed('/login');
      } else {
        Get.offNamed('/home');
      }
    });
  }

  void logout() async {
    isLoading.value = true;
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    isLoading.value = false;

    Get.offAllNamed('/login');
  }
}
