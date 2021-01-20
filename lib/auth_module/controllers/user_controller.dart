import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/auth_module/services/user_service.dart';
import 'package:hourli/models/user_deatils_model.dart';

class UserController extends GetxController {
  // services and other controller
  final _userService = UserService();
  final _authController = Get.find<AuthController>();

  //streams
  Rx<UserDetailsModel> firestoreUserStream = Rx<UserDetailsModel>();

  /// GETX Stuff ------------------------------------------------------<<<
  @override
  onInit() {
    firestoreUserStream.bindStream(_userService.firestoreUserStream(
        uid: _authController.firebaseUserStream.value.uid));
  }

  /// BUSSINESS LOGIC -------------------------------------------------<<<
  // Future<UserDetailsModel> check logic---getaUserDetails() async {
  //   try {
  //     _isLoging.value = true;
  //     await _authService.loginWithGoogle();
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error signing in",
  //       e.message,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     throw e;
  //   } finally {
  //     _isLoging.value = false;
  //   }
  // }

  Future<void> saveDeviceToken() async {
    try {
      await _userService.saveDeviceToken(
          uid: _authController.firebaseUserStream.value.uid);
    } catch (e) {
      print("Error in saving device token");
    }
  }
}
