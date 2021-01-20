// To parse this JSON data, do
//
//     final activityDetailsModel = activityDetailsModelFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityDetailsModel {
  ActivityDetailsModel({
    this.endsOn,
    this.targetMinutes,
    this.displayName,
    this.taskDescription,
    this.weekJsInt,
    this.userName,
    this.uid,
    this.endedAt,
    this.taskName,
    this.projectName,
    this.startedOn,
    this.projectId,
    this.taskId,
    this.status,
    this.timestamp,
  });

  Timestamp endsOn;
  int targetMinutes;
  String displayName;
  String taskDescription;
  int weekJsInt;
  String userName;
  String uid;
  Timestamp endedAt;
  String taskName;
  String projectName;
  Timestamp startedOn;
  String projectId;
  String taskId;
  String status;
  Timestamp timestamp;

  factory ActivityDetailsModel.fromJson(String str) =>
      ActivityDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActivityDetailsModel.fromMap(Map<String, dynamic> json) =>
      ActivityDetailsModel(
        endsOn: json["endsOn"],
        targetMinutes: json["targetMinutes"],
        displayName: json["displayName"],
        taskDescription: json["taskDescription"],
        weekJsInt: json["weekJsInt"],
        userName: json["userName"],
        uid: json["uid"],
        endedAt: json["endedAt"],
        taskName: json["taskName"],
        projectName: json["projectName"],
        startedOn: json["startedOn"],
        projectId: json["projectId"],
        taskId: json["taskId"],
        status: json["status"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toMap() => {
        "endsOn": endsOn,
        "targetMinutes": targetMinutes,
        "displayName": displayName,
        "taskDescription": taskDescription,
        "weekJsInt": weekJsInt,
        "userName": userName,
        "uid": uid,
        "endedAt": endedAt,
        "taskName": taskName,
        "projectName": projectName,
        "startedOn": startedOn,
        "projectId": projectId,
        "taskId": taskId,
        "status": status,
        "timestamp": timestamp,
      };
}
