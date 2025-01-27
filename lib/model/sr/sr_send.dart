// To parse this JSON data, do
//
//     final srSendModel = srSendModelFromJson(jsonString);

import 'dart:convert';

SrSendModel srSendModelFromJson(String str) =>
    SrSendModel.fromJson(json.decode(str));

String srSendModelToJson(SrSendModel data) => json.encode(data.toJson());

class SrSendModel {
  String? srType;
  String? details;
  String? userId;
  String? roomDesignation;

  SrSendModel({
    this.srType,
    this.details,
    this.userId,
    this.roomDesignation,
  });

  factory SrSendModel.fromJson(Map<String, dynamic> json) => SrSendModel(
        srType: json["sr_type"],
        details: json["details"],
        userId: json["user_id"],
        roomDesignation: json["room_designation"],
      );

  Map<String, dynamic> toJson() => {
        "sr_type": srType,
        "details": details,
        "user_id": userId,
        "room_designation": roomDesignation,
      };
}
