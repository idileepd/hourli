import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/services/auth_service.dart';

class AuthController extends GetxController {
  // services
  final _authService = AuthService();

  //streams
  Rx<User> firebaseUserStream = Rx<User>();
  RxBool _isLoging = false.obs;

  // Getters
  RxBool get isLoging => _isLoging;

  /// GETX Stuff ------------------------------------------------------<<<
  @override
  onInit() {
    firebaseUserStream
        .bindStream(_authService.firebaseAuthUser.authStateChanges());
  }

  @override
  void onClose() {
    // _userModelStream.close();
    super.onClose();
  }

  /// BUSSINESS LOGIC -------------------------------------------------<<<
  Future<void> loginWithGoogle() async {
    try {
      _isLoging.value = true;
      await _authService.loginWithGoogle();
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.message,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      throw e;
    } finally {
      _isLoging.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      // also clear device token in service ***
    } catch (e) {
      throw e;
    }
  }
}
