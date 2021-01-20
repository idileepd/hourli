import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseNotificationController extends GetxController {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void onInit() {
    initialise();
    super.onInit();
  }

  FirebaseMessaging get fcmInstance => _fcm;

  Future initialise() async {
    // print(await _fcm.getToken());

    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> msg) async {
        try {
          print("onMessage: ${msg['notification']['title']}");
          Get.snackbar(
            msg['notification']['title'],
            msg['notification']['body'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            duration: Duration(seconds: 15),
          );
          // Get.
          print("onMessage !!!");
        } catch (e) {
          print(e);
        }
      },
      onLaunch: (Map<String, dynamic> msg) async {
        print("onLaunch: $msg");
        // // Get.snackbar(msg['message']['title'], msg['message']['body']);
        // Get.snackbar(
        //   msg['notification']['title'],
        //   msg['notification']['body'],
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        // );
        print("onLaunch !!!");
      },
      onResume: (Map<String, dynamic> msg) async {
        // print("onResume: $msg");
        // Get.snackbar(
        //   msg['notification']['title'],
        //   msg['notification']['body'],
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        // );
        print("onResume !!!");
      },
    );
  }
}
