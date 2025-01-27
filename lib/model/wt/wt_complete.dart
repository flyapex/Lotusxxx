// To parse this JSON data, do
//
//     final wtCompletedModel = wtCompletedModelFromJson(jsonString);

import 'dart:convert';

WtCompletedModel wtCompletedModelFromJson(String str) =>
    WtCompletedModel.fromJson(json.decode(str));

String wtCompletedModelToJson(WtCompletedModel data) =>
    json.encode(data.toJson());

class WtCompletedModel {
  bool? success;
  String? message;
  Data? data;

  WtCompletedModel({
    this.success,
    this.message,
    this.data,
  });

  factory WtCompletedModel.fromJson(Map<String, dynamic> json) =>
      WtCompletedModel(
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
  String? costOfCorrection;
  String? clientApprovedRepair;
  DateTime? completedDate;

  Report({
    this.id,
    this.createdAt,
    this.costOfCorrection,
    this.clientApprovedRepair,
    this.completedDate,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        costOfCorrection: json["cost_of_correction"],
        clientApprovedRepair: json["client_approved_repair"],
        completedDate: json["completed_date"] == null
            ? null
            : DateTime.parse(json["completed_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "cost_of_correction": costOfCorrection,
        "client_approved_repair": clientApprovedRepair,
        "completed_date":
            "${completedDate!.year.toString().padLeft(4, '0')}-${completedDate!.month.toString().padLeft(2, '0')}-${completedDate!.day.toString().padLeft(2, '0')}",
      };
}
