import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline/event_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/models/activity_details_model.dart';

class UserTimeLineController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _authController = Get.find<AuthController>();

  // we gonna check if auth user is watching this user or not.
  Stream<List<TimelineEventDisplay>> userActivityStream(
      {@required String uid}) {
    if (_authController.firebaseUserStream.value.uid == uid)
      return _firestore
          .collection('activity')
          .where('uid', isEqualTo: uid)
          .limit(30)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((QuerySnapshot snap) {
        if (snap.docs == null) return null;
        List<TimelineEventDisplay> activities = [];
        snap.docs.forEach((projectDocSnapshot) {
          activities.add(
            _getActivityNode(
              activityDetailsModel: ActivityDetailsModel.fromMap(
                projectDocSnapshot.data(),
              ),
            ),
          );
        });
        return activities;
      });
    else {
      return _firestore
          .collection('activity')
          .where('uid', isEqualTo: uid)
          .where('isPrivate', isEqualTo: false)
          .limit(30)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((QuerySnapshot snap) {
        if (snap.docs == null) return null;
        List<TimelineEventDisplay> activities = [];
        snap.docs.forEach((projectDocSnapshot) {
          activities.add(
            _getActivityNode(
              activityDetailsModel: ActivityDetailsModel.fromMap(
                projectDocSnapshot.data(),
              ),
            ),
          );
        });
        return activities;
      });
    }
  }

  TimelineEventDisplay _getActivityNode(
      {@required ActivityDetailsModel activityDetailsModel}) {
    IconData icon = Icons.play_arrow;
    Color color = HLColors.primaryColorsList[1];
    String logText = '';
    if (activityDetailsModel.status == "DROPPED") {
      icon = Icons.block;
      color = Colors.orange;
      // logText = logText +
      //     "after ${DateFormat().addPattern('jm').addPattern('yMMMMd').format(activityDetailsModel.endedAt.toDate())}";
      logText = logText +
          "after ${activityDetailsModel.endedAt.toDate().difference(activityDetailsModel.startedOn.toDate()).inMinutes} Minutes";
    } else if (activityDetailsModel.status == "COMPLETED") {
      icon = Icons.check;
      color = Colors.green;
      logText = logText +
          "Totally ${activityDetailsModel.endedAt.toDate().difference(activityDetailsModel.startedOn.toDate()).inMinutes} Minutes spent";
    } else if (activityDetailsModel.status == "FAILED") {
      icon = Icons.cancel;
      color = Colors.red;
      logText = logText +
          "@ ${DateFormat().addPattern('jm').addPattern('yMMMMd').format(activityDetailsModel.endedAt.toDate())}";
    } else {
      //started
      logText = logText +
          "@ ${DateFormat().addPattern('jm').addPattern('yMMMMd').format(activityDetailsModel.startedOn.toDate())}";
    }
    return TimelineEventDisplay(
      child: TimelineEventCard(
        title: Text(
            "\n${activityDetailsModel.status}:  ${activityDetailsModel.taskName.toUpperCase()}"),
        content: Text(logText),
      ),
      indicator: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
