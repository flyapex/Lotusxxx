// To parse this JSON data, do
//
//     final hiSendModel = hiSendModelFromJson(jsonString);

import 'dart:convert';

HiSendModel hiSendModelFromJson(String str) =>
    HiSendModel.fromJson(json.decode(str));

String hiSendModelToJson(HiSendModel data) => json.encode(data.toJson());

class HiSendModel {
  String? details;
  String? userId;

  HiSendModel({
    this.details,
    this.userId,
  });

  factory HiSendModel.fromJson(Map<String, dynamic> json) => HiSendModel(
        details: json["details"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
        "user_id": userId,
      };
}
