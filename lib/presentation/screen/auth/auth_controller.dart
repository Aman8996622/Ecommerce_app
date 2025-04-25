import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movieapp/data/api_service/api_service.dart';
import 'package:movieapp/data/models/user_model.dart';
import 'package:movieapp/presentation/screen/home_screen/home_screen.dart';
import 'package:movieapp/presentation/screen/login/login_screen.dart';


class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  final GetStorage _storage = GetStorage();

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    final userData = _storage.read('user');
    if (userData != null) {
      user.value = UserModel.fromJson(userData);
    }
  }

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      final userData = await _apiService.login(username, password);
      user.value = userData;
      _storage.write('user', userData.toJson());
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    user.value = null;
    _storage.remove('user');
    Get.offAll(() => LoginScreen());
  }

  bool get isLoggedIn => user.value != null;
}
