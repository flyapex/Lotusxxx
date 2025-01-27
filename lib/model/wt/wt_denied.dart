// To parse this JSON data, do
//
//     final wtDeniedModel = wtDeniedModelFromJson(jsonString);

import 'dart:convert';

WtDeniedModel wtDeniedModelFromJson(String str) =>
    WtDeniedModel.fromJson(json.decode(str));

String wtDeniedModelToJson(WtDeniedModel data) => json.encode(data.toJson());

class WtDeniedModel {
  bool? success;
  String? message;
  Data? data;

  WtDeniedModel({
    this.success,
    this.message,
    this.data,
  });

  factory WtDeniedModel.fromJson(Map<String, dynamic> json) => WtDeniedModel(
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
  String? reasonForDenial;
  String? clientApprovedRepair;
  DateTime? denialDate;

  Report({
    this.id,
    this.createdAt,
    this.reasonForDenial,
    this.clientApprovedRepair,
    this.denialDate,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        reasonForDenial: json["reason_for_denial"],
        clientApprovedRepair: json["client_approved_repair"],
        denialDate: json["denial_date"] == null
            ? null
            : DateTime.parse(json["denial_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "reason_for_denial": reasonForDenial,
        "client_approved_repair": clientApprovedRepair,
        "denial_date":
            "${denialDate!.year.toString().padLeft(4, '0')}-${denialDate!.month.toString().padLeft(2, '0')}-${denialDate!.day.toString().padLeft(2, '0')}",
      };
}
