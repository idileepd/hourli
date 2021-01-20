import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hourli/global_module/utils/hl_config.dart';
import 'package:hourli/global_module/utils/hl_theme.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  var themeIndexRx = 1.obs;
  int get themeIndex => themeIndexRx.value;
  @override
  void onInit() {
    int themeIndex = _box.read(HLConfig.themeIndexStorageKey);
    if (themeIndex == null) {
      _box.write(HLConfig.themeIndexStorageKey, 1);
      themeIndex = 1;
    }
    themeIndexRx.value = themeIndex;
    //initialize theme
    if (themeIndexRx.value == 1) {
      Get.changeTheme(HLThemesData.themesMap[HLThemes.dark]);
    } else {
      Get.changeTheme(HLThemesData.themesMap[HLThemes.light]);
    }
    super.onInit();
  }

  void toggleTheme() {
    if (Get.isDarkMode) {
      _box.write(HLConfig.themeIndexStorageKey, 0);
      Get.changeTheme(HLThemesData.themesMap[HLThemes.light]);
      themeIndexRx.value = 0;
    } else {
      _box.write(HLConfig.themeIndexStorageKey, 1);
      Get.changeTheme(HLThemesData.themesMap[HLThemes.dark]);
      themeIndexRx.value = 1;
    }
  }

  void clearTheme() {
    if (!Get.isDarkMode) {
      _box.write(HLConfig.themeIndexStorageKey, 1);
      Get.changeTheme(HLThemesData.themesMap[HLThemes.dark]);
      themeIndexRx.value = 1;
    }
  }
}
