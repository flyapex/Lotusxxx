// To parse this JSON data, do
//
//     final wtOpenModel = wtOpenModelFromJson(jsonString);

import 'dart:convert';

WtOpenModel wtOpenModelFromJson(String str) =>
    WtOpenModel.fromJson(json.decode(str));

String wtOpenModelToJson(WtOpenModel data) => json.encode(data.toJson());

class WtOpenModel {
  bool? success;
  String? message;
  Data? data;

  WtOpenModel({
    this.success,
    this.message,
    this.data,
  });

  factory WtOpenModel.fromJson(Map<String, dynamic> json) => WtOpenModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<Report>? reports;

  Data({
    this.reports,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reports: json["reports"] == null
            ? []
            : List<Report>.from(
                json["reports"]!.map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reports": reports == null
            ? []
            : List<dynamic>.from(reports!.map((x) => x.toJson())),
      };
}

class Report {
  int? id;
  DateTime? createdAt;
  String? lastActionDesc;

  Report({
    this.id,
    this.createdAt,
    this.lastActionDesc,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        lastActionDesc: json["last_action_desc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "last_action_desc": lastActionDesc,
      };
}
