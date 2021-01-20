// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserDetailsModel {
//   UserDetailsModel({
//     this.saturday,
//     this.searchTags,
//     this.currentTask,
//     this.failedScore,
//     this.watchers,
//     this.thursday,
//     this.userName,
//     this.todayDate,
//     this.watchings,
//     this.deviceToken,
//     this.uid,
//     this.photoUrl,
//     this.todayScore,
//     this.sunday,
//     this.joinedOn,
//     this.tuesday,
//     this.name,
//     this.friday,
//     this.wednesday,
//     this.successScore,
//     this.savedTaskNames,
//     this.email,
//     this.monday,
//   });

//   int saturday;
//   List<String> searchTags;
//   CurrentTask currentTask;
//   int failedScore;
//   int watchers;
//   int thursday;
//   String userName;
//   Timestamp todayDate;
//   int watchings;
//   String deviceToken;
//   String uid;
//   String photoUrl;
//   int todayScore;
//   int sunday;
//   Timestamp joinedOn;
//   List<String> savedTaskNames;
//   int tuesday;
//   String name;
//   int friday;
//   int wednesday;
//   int successScore;
//   String email;
//   int monday;

//   factory UserDetailsModel.fromJson(String str) =>
//       UserDetailsModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory UserDetailsModel.fromMap(Map<String, dynamic> json) {
//     if (json == null) return null;
//     // print(json["todayDate"]);
//     return UserDetailsModel(
//       saturday: json["saturday"],
//       searchTags: List<String>.from(json["searchTags"].map((x) => x)),
//       currentTask: CurrentTask.fromMap(json["currentTask"]),
//       failedScore: json["failedScore"],
//       watchers: json["watchers"],
//       savedTaskNames: List<String>.from(json["savedTaskNames"].map((x) => x)),
//       thursday: json["thursday"],
//       userName: json["userName"],
//       todayDate: json["todayDate"],
//       watchings: json["watchings"],
//       deviceToken: json["deviceToken"],
//       uid: json["uid"],
//       photoUrl: json["photoUrl"],
//       todayScore: json["todayScore"],
//       sunday: json["sunday"],
//       joinedOn: json["joinedOn"],
//       tuesday: json["tuesday"],
//       name: json["name"],
//       friday: json["friday"],
//       wednesday: json["wednesday"],
//       successScore: json["successScore"],
//       email: json["email"],
//       monday: json["monday"],
//     );
//   }
//   Map<String, dynamic> toMap() => {
//         "saturday": saturday,
//         "searchTags": List<dynamic>.from(searchTags.map((x) => x)),
//         "currentTask": currentTask.toMap(),
//         "failedScore": failedScore,
//         "watchers": watchers,
//         "thursday": thursday,
//         "userName": userName,
//         "todayDate": todayDate,
//         "watchings": watchings,
//         "deviceToken": deviceToken,
//         "uid": uid,
//         "photoUrl": photoUrl,
//         "todayScore": todayScore,
//         "sunday": sunday,
//         "joinedOn": joinedOn,
//         "tuesday": tuesday,
//         "savedTaskNames": List<dynamic>.from(savedTaskNames.map((x) => x)),
//         "name": name,
//         "friday": friday,
//         "wednesday": wednesday,
//         "successScore": successScore,
//         "email": email,
//         "monday": monday,
//       };

//   int getWeekScore() {
//     int weekScore = 0;
//     weekScore += this.monday;
//     weekScore += this.tuesday;
//     weekScore += this.wednesday;
//     weekScore += this.thursday;
//     weekScore += this.friday;
//     weekScore += this.saturday;
//     weekScore += this.sunday;
//     return weekScore;
//   }
// }

// class CurrentTask {
//   CurrentTask({
//     this.endsOn,
//     this.endedAt,
//     this.taskDescription,
//     this.taskName,
//     this.startedOn,
//     this.status,
//   });

//   Timestamp endsOn;
//   Timestamp endedAt;
//   String taskDescription;
//   String taskName;
//   Timestamp startedOn;
//   String status;

//   factory CurrentTask.fromJson(String str) =>
//       CurrentTask.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory CurrentTask.fromMap(Map<String, dynamic> json) => CurrentTask(
//         endsOn: json["endsOn"],
//         endedAt: json["endedAt"],
//         taskDescription: json["taskDescription"],
//         taskName: json["taskName"],
//         startedOn: json["startedOn"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toMap() => {
//         "endsOn": endsOn,
//         "endedAt": endedAt,
//         "taskDescription": taskDescription,
//         "taskName": taskName,
//         "startedOn": startedOn,
//         "status": status,
//       };
// }

///
///
///
// To parse this JSON data, do
//
//     final courseLiveAttendanceData = courseLiveAttendanceDataFromMap(jsonString);
// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  UserDetailsModel({
    this.deviceTokenStatus,
    this.week,
    this.displayName,
    this.searchTags,
    this.currentTask,
    this.watchers,
    this.userName,
    this.watchings,
    this.deviceToken,
    this.photoUrl,
    this.score,
    this.uid,
    this.joinedOn,
    this.today,
    this.email,
  });

  bool deviceTokenStatus;
  Map<String, int> week;
  String displayName;
  List<String> searchTags;
  CurrentTask currentTask;
  int watchers;
  String userName;
  int watchings;
  String deviceToken;
  String photoUrl;
  int score;
  String uid;
  Timestamp joinedOn;
  Today today;
  String email;

  int getWeekScore() {
    int weekScore = 0;
    weekScore += this.week['0'];
    weekScore += this.week['1'];
    weekScore += this.week['2'];
    weekScore += this.week['3'];
    weekScore += this.week['4'];
    weekScore += this.week['5'];
    weekScore += this.week['6'];
    return weekScore;
  }

  factory UserDetailsModel.fromJson(String str) =>
      UserDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDetailsModel.fromMap(Map<String, dynamic> json) =>
      UserDetailsModel(
        deviceTokenStatus: json["deviceTokenStatus"],
        week: Map.from(json["week"]).map((k, v) => MapEntry<String, int>(k, v)),
        displayName: json["displayName"],
        searchTags: List<String>.from(json["searchTags"].map((x) => x)),
        currentTask: CurrentTask.fromMap(json["currentTask"]),
        watchers: json["watchers"],
        userName: json["userName"],
        watchings: json["watchings"],
        deviceToken: json["deviceToken"],
        photoUrl: json["photoUrl"],
        score: json["score"],
        uid: json["uid"],
        joinedOn: json["joinedOn"],
        today: Today.fromMap(json["today"]),
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "deviceTokenStatus": deviceTokenStatus,
        "week": Map.from(week).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "displayName": displayName,
        "searchTags": List<dynamic>.from(searchTags.map((x) => x)),
        "currentTask": currentTask.toMap(),
        "watchers": watchers,
        "userName": userName,
        "watchings": watchings,
        "deviceToken": deviceToken,
        "photoUrl": photoUrl,
        "score": score,
        "uid": uid,
        "joinedOn": joinedOn,
        "today": today.toMap(),
        "email": email,
      };
}

class CurrentTask {
  CurrentTask({
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
    this.projectId,
    this.startedOn,
    this.taskId,
    this.status,
    this.isPrivate,
    this.taskType,
  });

  int taskType;
  Timestamp endsOn;
  int targetMinutes;
  String displayName;
  String taskDescription;
  int weekJsInt;
  String userName;
  bool isPrivate;
  String uid;
  Timestamp endedAt;
  String taskName;
  String projectName;
  String projectId;
  Timestamp startedOn;
  String taskId;
  String status;

  factory CurrentTask.fromJson(String str) =>
      CurrentTask.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CurrentTask.fromMap(Map<String, dynamic> json) => CurrentTask(
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
        projectId: json["projectId"],
        startedOn: json["startedOn"],
        taskId: json["taskId"],
        status: json["status"],
        taskType: json["taskType"] ?? 0,
        isPrivate: json["isPrivate"] ?? false,
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
        "projectId": projectId,
        "startedOn": startedOn,
        "taskId": taskId,
        "status": status,
        "taskType": taskType,
        "isPrivate": isPrivate ?? false,
      };
}

class Today {
  Today({
    this.todayScore,
    this.todayDate,
  });

  int todayScore;
  Timestamp todayDate;

  factory Today.fromJson(String str) => Today.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Today.fromMap(Map<String, dynamic> json) => Today(
        todayScore: json["todayScore"],
        todayDate: json["todayDate"],
      );

  Map<String, dynamic> toMap() => {
        "todayScore": todayScore,
        "todayDate": todayDate,
      };
}
