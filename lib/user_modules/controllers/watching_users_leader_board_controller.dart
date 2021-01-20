import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/models/user_deatils_model.dart';

class WatchingUsersLeaderBoardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _authController = Get.find<AuthController>();

  Rx<List<UserDetailsModel>> watchingUsersModelsRx =
      Rx<List<UserDetailsModel>>();
  List<String> finalWatchingUserIds = [];
  List<UserDetailsModel> finalWatchingUserModels = [];

  @override
  void onInit() {
    super.onInit();
  }

  Stream<List<String>> watchingUserIdsList() {
    return _firestore
        .collection('watchings')
        // .where("searchTags", arrayContains: userName)
        // .limit(10)
        .doc(_authController.firebaseUserStream.value.uid)
        .collection('watchings')
        .where("watching", isEqualTo: true)
        .snapshots()
        .map((QuerySnapshot snap) {
      List<String> watchingUserIds = [];
      snap.docs.forEach((userDoc) {
        watchingUserIds.add(userDoc.id);
      });
      // print("Got LeaderBoard users");
      finalWatchingUserIds = watchingUserIds;
      return watchingUserIds;
    });
  }

  Stream<List<UserDetailsModel>> leaderBoardStream(
      {@required List<String> watchingUserIds}) {
    return _firestore
        .collection('users')
        .where("uid", whereIn: watchingUserIds)
        .orderBy("today.todayScore", descending: true)
        .snapshots()
        .map((QuerySnapshot snap) {
      // print("\n\n\n\n");
      // print("LEADERDBOAD STREAM");
      // print(snap.docs.length);
      List<UserDetailsModel> watchingUsersWithDetails = [];
      snap.docs.forEach((DocumentSnapshot userDoc) {
        watchingUsersWithDetails.add(
          UserDetailsModel.fromMap(userDoc.data()),
        );
      });
      finalWatchingUserModels = watchingUsersWithDetails;
      // print("Got Docs 2");
      return watchingUsersWithDetails;
    });
  }
}
