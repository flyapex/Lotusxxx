// To parse this JSON data, do
//
//     final wtAllModel = wtAllModelFromJson(jsonString);

import 'dart:convert';

WtAllModel wtAllModelFromJson(String str) =>
    WtAllModel.fromJson(json.decode(str));

String wtAllModelToJson(WtAllModel data) => json.encode(data.toJson());

class WtAllModel {
  bool? success;
  String? message;
  Data? data;

  WtAllModel({
    this.success,
    this.message,
    this.data,
  });

  factory WtAllModel.fromJson(Map<String, dynamic> json) => WtAllModel(
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
  int? totalPages;

  Data({
    this.reports,
    this.totalPages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reports: json["reports"] == null
            ? []
            : List<Report>.from(
                json["reports"]!.map((x) => Report.fromJson(x))),
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "reports": reports == null
            ? []
            : List<dynamic>.from(reports!.map((x) => x.toJson())),
        "totalPages": totalPages,
      };
}

class Report {
  int? id;
  DateTime? createdAt;

  Report({
    this.id,
    this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
      };
}
