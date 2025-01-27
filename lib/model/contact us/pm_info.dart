// To parse this JSON data, do
//
//     final pminfoModel = pminfoModelFromJson(jsonString);

import 'dart:convert';

PminfoModel pminfoModelFromJson(String str) =>
    PminfoModel.fromJson(json.decode(str));

String pminfoModelToJson(PminfoModel data) => json.encode(data.toJson());

class PminfoModel {
  bool? success;
  String? message;
  String? pmName;

  PminfoModel({
    this.success,
    this.message,
    this.pmName,
  });

  factory PminfoModel.fromJson(Map<String, dynamic> json) => PminfoModel(
        success: json["success"],
        message: json["message"],
        pmName: json["pm_name"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pm_name": pmName,
      };
}
