import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/models/user_deatils_model.dart';

class SearchUserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final _authController = Get.find<AuthController>();

  // // List<String> finalWatchingUserIds = [];
  // RxString searchUserName = ''.obs;

  Stream<List<UserDetailsModel>> searchUsersStream(
      {@required String userName}) {
    return _firestore
        .collection('users')
        .where("searchTags", arrayContains: userName)
        .limit(5)
        .snapshots()
        .map((QuerySnapshot snap) {
      List<UserDetailsModel> watchingUsersWithDetails = [];
      snap.docs.forEach((DocumentSnapshot userDoc) {
        watchingUsersWithDetails.add(
          UserDetailsModel.fromMap(userDoc.data()),
        );
      });
      return watchingUsersWithDetails;
    });
  }
}
