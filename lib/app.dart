import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/auth_router.dart';
import 'package:hourli/global_module/controllers/theme_controller.dart';
import 'package:hourli/global_module/utils/hl_theme.dart';
import 'package:hourli/auth_module/pages/login_page.dart';
import 'package:hourli/user_modules/pages/takooo_user_details_page.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(
          color: Color(0xFFF5F5F5),
        ),
      ),
      defaultTransition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 200),
      home: AuthRouter(),
      theme: getTheme(),
      getPages: [
        GetPage(name: '/', page: () => AuthRouter()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(
            name: '/hourlieUserDetailsPage',
            page: () => TakoooUserDetailsPage()),
      ],
    );
  }

  ThemeData getTheme() {
    ThemeController themeController = Get.find<ThemeController>();
    if (themeController.themeIndex == 1) {
      return HLThemesData.themesMap[HLThemes.dark];
    } else {
      return HLThemesData.themesMap[HLThemes.light];
    }
  }
}
