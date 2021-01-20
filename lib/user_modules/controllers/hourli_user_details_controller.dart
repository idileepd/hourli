import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
// import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/models/user_deatils_model.dart';

class HourliUserDetailsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _authController = Get.find<AuthController>();

  // // List<String> finalWatchingUserIds = [];
  // RxString searchUserName = ''.obs;

  // Stream<List<UserDetailsModel>> searchUsersStream(
  //     {@required String userName}) {
  //   return Firestore.instance
  //       .collection('users')
  //       .where("searchTags", arrayContains: userName)
  //       .limit(5)
  //       .snapshots()
  //       .map((QuerySnapshot snap) {
  //     List<UserDetailsModel> watchingUsersWithDetails = [];
  //     snap.documents.forEach((DocumentSnapshot userDoc) {
  //       watchingUsersWithDetails.add(
  //         UserDetailsModel.fromQueryDocSnapshot(userDoc),
  //       );
  //     });
  //     return watchingUsersWithDetails;
  //   });
  // }

  // // we gonna check if auth user is present in this page user's watchers list or not.
  // Stream<DocumentSnapshot> pageUserWatcherUsersStream({@required String uid}) {
  //   return Firestore.instance
  //       .collection('watchers')
  //       .doc(uid)
  //       .collection('watchers')
  //       .doc(_authController.firebaseUserStream.value.uid)
  //       .snapshots()
  //       .map((DocumentSnapshot snap) {
  //     // if (snap.data == null) return null;
  //     return snap;
  //   });
  // }

  // we gonna check if auth user is watching this user or not.
  Stream<DocumentSnapshot> authUserWatchingsUsersStream(
      {@required String uid}) {
    return _firestore
        .collection('watchings')
        .doc(_authController.firebaseUserStream.value.uid)
        .collection('watchings')
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snap) {
      // if (snap.data == null) return null;
      return snap;
    });
  }

  Future<void> unwatchUser({@required String unwatchingUserUid}) async {
    try {
      await _firestore
          .collection('watchings')
          .doc(_authController.firebaseUserStream.value.uid)
          .collection('watchings')
          .doc(unwatchingUserUid)
          .set({"uid": unwatchingUserUid, "watching": false});
    } catch (e) {
      print("Error $e");
    }
  }

  Future<void> watchUser({@required String watchingUserUid}) async {
    try {
      await _firestore
          .collection('watchings')
          .doc(_authController.firebaseUserStream.value.uid)
          .collection('watchings')
          .doc(watchingUserUid)
          .set({"uid": watchingUserUid, "watching": true});
    } catch (e) {
      print("Error $e");
    }
  }

  // Stream<List<UserDetailsModel>> uesrDetailsStream({@required String uid}) {
  //   return Firestore.instance.collection('users').doc(uid).snapshots()
  //       .map((QuerySnapshot snap) {
  //     List<UserDetailsModel> watchingUsersWithDetails = [];
  //     snap.documents.forEach((DocumentSnapshot userDoc) {
  //       watchingUsersWithDetails.add(
  //         UserDetailsModel.fromQueryDocSnapshot(userDoc),
  //       );
  //     });
  //     return watchingUsersWithDetails;
  //   });
  // }

  Stream<UserDetailsModel> uesrDetailsStream({@required String uid}) {
    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snap) {
      return UserDetailsModel.fromMap(snap.data());
    });
  }
}
