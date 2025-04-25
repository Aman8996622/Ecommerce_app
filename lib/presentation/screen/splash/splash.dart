import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/presentation/screen/auth/auth_controller.dart';
import 'package:movieapp/presentation/screen/home_screen/home_screen.dart';
import 'package:movieapp/presentation/screen/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (_authController.isLoggedIn) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 16),
            Text(
              'ShopEase',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your One-Stop Shopping Destination',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
