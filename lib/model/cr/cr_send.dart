// To parse this JSON data, do
//
//     final conciergeRequestSendModel = conciergeRequestSendModelFromJson(jsonString);

import 'dart:convert';

ConciergeRequestSendModel conciergeRequestSendModelFromJson(String str) =>
    ConciergeRequestSendModel.fromJson(json.decode(str));

String conciergeRequestSendModelToJson(ConciergeRequestSendModel data) =>
    json.encode(data.toJson());

class ConciergeRequestSendModel {
  String details;
  String userId;

  ConciergeRequestSendModel({
    required this.details,
    required this.userId,
  });

  ConciergeRequestSendModel copyWith({
    String? details,
    String? userId,
  }) =>
      ConciergeRequestSendModel(
        details: details ?? this.details,
        userId: userId ?? this.userId,
      );

  factory ConciergeRequestSendModel.fromJson(Map<String, dynamic> json) =>
      ConciergeRequestSendModel(
        details: json["details"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
        "user_id": userId,
      };
}
