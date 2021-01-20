import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hourli/app.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/global_module/controllers/firebase_notification_controller.dart';
import 'package:hourli/global_module/controllers/theme_controller.dart';
import 'package:hourli/global_module/controllers/local_notification_controller.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // init storage
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  // Init global objects, remains in memory until app dies
  Get.put<AuthController>(AuthController(), permanent: true);
  Get.put<ThemeController>(ThemeController(), permanent: true);

  //notification stuff
  Get.put<LocalNotificationController>(LocalNotificationController(),
      permanent: true);
  Get.put<FirebaseNotificationController>(FirebaseNotificationController(),
      permanent: true);

  runApp(App());
  // runApp(DevicePreview(
  //   // enabled: !kReleaseMode,
  //   builder: (context) => App(),
  // ));
}
