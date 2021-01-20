import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/authorize_router.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/auth_module/pages/login_page.dart';

class AuthRouter extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetX(
      builder: (_) {
        return _authenticateUser();
      },
    );
    // return Obx(() => _authenticateUser());

    // return StreamBuilder<FirebaseUser>(
    //     stream: authController.authNormalStream,
    //     builder: (context, snap) {
    //       if (snap.hasData && snap.data?.uid != null) {
    //         print("AUTH USER : ${snap?.data?.uid}");

    //         return AuthorizeRouter();
    //       } else {
    //         return LoginPage();
    //       }
    //     });
  }

  Widget _authenticateUser() {
    if (authController.firebaseUserStream.value?.uid != null) {
      return AuthorizeRouter();
    } else {
      return LoginPage();
    }
  }
}
