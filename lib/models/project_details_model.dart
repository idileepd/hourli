// To parse this JSON data, do
//
//     final projectDetailsModel = projectDetailsModelFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectDetailsModel {
  ProjectDetailsModel({
    this.uids,
    this.minutesSpent,
    this.projectName,
    this.colorHex,
    this.adminUid,
    this.projectId,
    this.createdOn,
    this.isFavourite,
    this.projectType,
  });

  List<String> uids;
  int minutesSpent;
  String projectName;
  String colorHex;
  String adminUid;
  String projectId;
  Timestamp createdOn;
  bool isFavourite;
  int projectType; //-1, 0, 1 >>
  // factory ProjectDetailsModel.fromJson(String str) =>
  //     ProjectDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProjectDetailsModel.fromMap(
          Map<String, dynamic> json, String projectId) =>
      ProjectDetailsModel(
        uids: List<String>.from(json["uids"].map((x) => x)),
        minutesSpent: json["minutesSpent"],
        projectName: json["projectName"],
        colorHex: json["colorHex"],
        projectId: projectId,
        adminUid: json["adminUid"],
        createdOn: json['createdOn'],
        isFavourite: json['isFavourite'],
        projectType: json['projectType'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "uids": List<dynamic>.from(uids.map((x) => x)),
        "minutesSpent": minutesSpent,
        "projectName": projectName,
        "colorHex": colorHex,
        "adminUid": adminUid,
      };
}
