// To parse this JSON data, do
//
//     final depSendModel = depSendModelFromJson(jsonString);

import 'dart:convert';

DepSendModel depSendModelFromJson(String str) =>
    DepSendModel.fromJson(json.decode(str));

String depSendModelToJson(DepSendModel data) => json.encode(data.toJson());

class DepSendModel {
  String? date;
  String? time;
  int? userId;
  String? housekeeping;
  String? automobiles;
  String? trashRecycle;
  String? additional;

  DepSendModel({
    this.date,
    this.time,
    this.userId,
    this.housekeeping,
    this.automobiles,
    this.trashRecycle,
    this.additional,
  });

  factory DepSendModel.fromJson(Map<String, dynamic> json) => DepSendModel(
        date: json["date"],
        time: json["time"],
        userId: json["user_id"],
        housekeeping: json["housekeeping"],
        automobiles: json["automobiles"],
        trashRecycle: json["trash_recycle"],
        additional: json["additional"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "user_id": userId,
        "housekeeping": housekeeping,
        "automobiles": automobiles,
        "trash_recycle": trashRecycle,
        "additional": additional,
      };
}
