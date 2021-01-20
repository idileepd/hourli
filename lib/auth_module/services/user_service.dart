import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hourli/global_module/controllers/firebase_notification_controller.dart';
import 'package:hourli/models/user_deatils_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserDetailsModel> getUserDetails({@required String uid}) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();

      return UserDetailsModel.fromMap(_doc.data());
    } catch (e) {
      print('[user service] error getting user details : $e');
      rethrow;
    }
  }

  Stream<UserDetailsModel> firestoreUserStream({@required String uid}) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((userDocSnapshot) {
      print("USER DATA");
      // print(userDocSnapshot.data());
      if (userDocSnapshot.data() == null) return null;
      return UserDetailsModel.fromMap(userDocSnapshot.data());
    });
  }

  Future saveDeviceToken({@required String uid}) async {
    try {
      String deviceToken = await Get.find<FirebaseNotificationController>()
          .fcmInstance
          .getToken();

      await _firestore.collection("users").doc(uid).update({
        "deviceToken": deviceToken,
        "deviceTokenStatus": true,
      });
    } catch (e) {
      // print('[user service] Error storing token: $e');
    }
  }
}
