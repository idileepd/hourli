// To parse this JSON data, do
//
//     final taskDetailsModel = taskDetailsModelFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDetailsModel {
  TaskDetailsModel({
    this.uids,
    this.minutesSpent,
    this.isCompleted,
    this.taskName,
    this.adminUid,
    this.taskId,
    this.createdOn,
    this.lastUpdateOn,
    // this.taskType,
  });

  List<String> uids;
  int minutesSpent;
  bool isCompleted;
  String taskName;
  String adminUid;
  String taskId;
  Timestamp createdOn;
  Timestamp lastUpdateOn;
  // int taskType;
  // factory TaskDetailsModel.fromJson(String str) =>
  //     TaskDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskDetailsModel.fromMap(Map<String, dynamic> json, String taskId) =>
      TaskDetailsModel(
        uids: List<String>.from(json["uids"].map((x) => x)),
        minutesSpent: json["minutesSpent"],
        isCompleted: json["isCompleted"],
        taskName: json["taskName"],
        adminUid: json["adminUid"],
        taskId: taskId,
        createdOn: json['createdOn'],
        lastUpdateOn: json['lastUpdateOn'],
        // taskType: json['taskType'],
      );

  Map<String, dynamic> toMap() => {
        "uids": List<dynamic>.from(uids.map((x) => x)),
        "minutesSpent": minutesSpent,
        "isCompleted": isCompleted,
        "taskName": taskName,
        "adminUid": adminUid,
      };
}
