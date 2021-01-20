import 'dart:convert';

class MessageDetailsModel {
  MessageDetailsModel({
    this.message,
    this.timestamp,
    this.userName,
    this.messageBy,
  });

  String message;
  String timestamp;
  String userName;
  String messageBy;

  factory MessageDetailsModel.fromJson(String str) =>
      MessageDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageDetailsModel.fromMap(Map<String, dynamic> json) =>
      MessageDetailsModel(
        message: json["message"],
        timestamp: json["timestamp"],
        userName: json["userName"],
        messageBy: json["messageBy"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "timestamp": timestamp,
        "userName": userName,
        "messageBy": messageBy,
      };
}
