// // To parse this JSON data, do
// //
// //     final currentTaskModel = currentTaskModelFromMap(jsonString);

// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// class CurrentTaskModel {
//   CurrentTaskModel({
//     this.uid,
//     this.taskName,
//     this.photoUrl,
//     this.startedAt,
//     this.endsAt,
//     this.status,
//   });

//   String uid;
//   String taskName;
//   String photoUrl;
//   DateTime startedAt;
//   DateTime endsAt;
//   String status;

//   CurrentTaskModel.createTaskCurrentTask({
//     @required this.uid,
//     @required this.taskName,
//     @required this.startedAt,
//     @required this.endsAt,
//     @required this.photoUrl,
//     @required this.status,
//   });

//   factory CurrentTaskModel.fromJson(String str) =>
//       CurrentTaskModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory CurrentTaskModel.fromMap(Map<String, dynamic> json) =>
//       CurrentTaskModel(
//         uid: json["uid"],
//         taskName: json["taskName"],
//         photoUrl: json["photoUrl"],
//         startedAt: DateTime.parse(json["startedAt"]),
//         endsAt: DateTime.parse(json["endsAt"]),
//         status: json["status"],
//       );

//   Map<String, dynamic> toMap() => {
//         "uid": uid,
//         "taskName": taskName,
//         "photoUrl": photoUrl,
//         "startedAt": startedAt.toIso8601String(),
//         "endsAt": endsAt.toIso8601String(),
//         "status": status,
//       };
// }
