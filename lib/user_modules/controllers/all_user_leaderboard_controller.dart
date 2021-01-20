import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/models/user_deatils_model.dart';

class AllUserLeaderBoardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<List<UserDetailsModel>> todaytop10UsersModelsRx =
      Rx<List<UserDetailsModel>>();
  List<UserDetailsModel> finalWatchingUserModels = [];

  @override
  void onInit() {
    todaytop10UsersModelsRx.bindStream(todayTop10Users());
    super.onInit();
  }

  Stream<List<UserDetailsModel>> todayTop10Users() {
    return _firestore
        .collection('users')
        .orderBy("today.todayScore", descending: true)
        .limit(10)
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
