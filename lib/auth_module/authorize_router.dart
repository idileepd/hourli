import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/global_module/helper_pages.dart/loading_page.dart';
import 'package:hourli/user_modules/pages/dashboard_page.dart';

class AuthorizeRouter extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      init: UserController(),
      builder: (_) {
        // if (Get.find<AuthController>().firebaseUserStream.value?.uid != null) {
        //   print(Get.find<AuthController>().currentUserSnap?.data.toString());
        //   return DashboardPage();
        // } else {
        //   return LoginPage();
        // }
        final userController = Get.find<UserController>();
        if (userController.firestoreUserStream.value.isNullOrBlank) {
          return LoadingPage();
        } else {
          userController.saveDeviceToken();
          return DashboardPage();
        }
      },
    );
  }
}
