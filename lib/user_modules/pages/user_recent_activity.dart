import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/global_module/components/heading_text_component.dart';
import 'package:hourli/user_modules/pages/user_timeline_component.dart';

class UserRecentActivity extends StatelessWidget {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          children: [
            HeadingTextComponent(
              title: 'Recent Activity',
              showBack: true,
            ),
            UserTimelineComponent(
              uid: _authController.firebaseUserStream.value.uid,
            )
          ],
        ),
      ),
    );
  }
}
