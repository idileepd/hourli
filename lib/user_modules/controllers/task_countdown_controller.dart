import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/global_module/controllers/local_notification_controller.dart';
import 'package:hourli/models/user_deatils_model.dart';

class TaskCountDownController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _authController = Get.find<AuthController>();
  final _userController = Get.find<UserController>();
  final _localNotificaion = Get.find<LocalNotificationController>();
  var rng = new Random();
  Future<void> startWork({@required CurrentTask currentTask}) async {
    bool result = await DataConnectionChecker().hasConnection;

    if (result == false) throw 'You are offline!';

    try {
      DateTime endsOntime =
          DateTime.now().add(Duration(minutes: currentTask.targetMinutes));
      int dartWeekDay = DateTime.now().weekday;
      int jsWeekDay = dartWeekDay == 7 ? 0 : dartWeekDay;

      UserDetailsModel userDetailsModel =
          _userController.firestoreUserStream.value;
      currentTask.uid = _authController.firebaseUserStream.value.uid;
      currentTask.displayName = userDetailsModel.displayName;
      currentTask.userName = userDetailsModel.userName;
      currentTask.startedOn = Timestamp.now();
      currentTask.endsOn = Timestamp.fromDate(endsOntime);
      currentTask.endedAt = null;
      currentTask.status = "STARTED";
      currentTask.taskDescription = "";
      currentTask.weekJsInt = jsWeekDay;
      print(currentTask.toMap());
      final title = "Completed task ?";
      _localNotificaion.showNotificationAfter(
        minutes: currentTask.targetMinutes,
        title: title,
        body: currentTask.taskName,
        id: rng.nextInt(10000),
      );
      await _firestore.collection('users').doc(currentTask.uid).update({
        "currentTask": currentTask.toMap(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> completedWork() async {
    bool result = await DataConnectionChecker().hasConnection;

    if (result == true) {
      String status = "";

      DateTime actualTaskEndsAtWithPading = _userController
          .firestoreUserStream.value.currentTask.endsOn
          .toDate()
          .add(Duration(minutes: 60));
      if (DateTime.now().isAfter(actualTaskEndsAtWithPading)) {
        // failed task
        status = "FAILED";
      } else {
        //success task
        status = "COMPLETED";
      }

      await _firestore
          .collection('users')
          .doc(_userController.firestoreUserStream.value.uid)
          .update({
        "currentTask.status": status,
        "currentTask.endedAt": Timestamp.now(),
      });
      _localNotificaion.cancelAllNotifications();
    } else {
      throw 'You are offline!';
    }
  }

  Future<void> dropTask() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      await _firestore
          .collection('users')
          .doc(_userController.firestoreUserStream.value.uid)
          .update({
        "currentTask.status": "DROPPED",
        "currentTask.endedAt": Timestamp.now(),
      });
      _localNotificaion.cancelAllNotifications();
    } else {
      throw 'You are offline!';
    }
  }

  failedWork() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      await _firestore
          .collection('users')
          .doc(_userController.firestoreUserStream.value.uid)
          .update({
        "currentTask.status": "FAILED",
        "currentTask.endedAt": Timestamp.now(),
      });
      _localNotificaion.cancelAllNotifications();
    } else {
      throw 'You are offline!';
    }
  }
}
