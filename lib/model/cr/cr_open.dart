// To parse this JSON data, do
//
//     final cRreceiveModel = cRreceiveModelFromJson(jsonString);

import 'dart:convert';

CRreceiveModel cRreceiveModelFromJson(String str) =>
    CRreceiveModel.fromJson(json.decode(str));

String cRreceiveModelToJson(CRreceiveModel data) => json.encode(data.toJson());

class CRreceiveModel {
  bool? success;
  String? message;
  Data? data;

  CRreceiveModel({
    this.success,
    this.message,
    this.data,
  });

  factory CRreceiveModel.fromJson(Map<String, dynamic> json) => CRreceiveModel(
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
  List<CrInfo>? crInfos;

  Data({
    this.crInfos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        crInfos: json["crInfos"] == null
            ? []
            : List<CrInfo>.from(
                json["crInfos"]!.map((x) => CrInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "crInfos": crInfos == null
            ? []
            : List<dynamic>.from(crInfos!.map((x) => x.toJson())),
      };
}

class CrInfo {
  int? id;
  String? description;
  DateTime? submitDate;
  dynamic clientApprovedRepair;
  dynamic completedDate;
  dynamic denialDate;
  dynamic reasonForDenial;
  dynamic costOfCorrection;
  String? managerQuote;
  dynamic staffQuote;
  String? status;
  String? userId;
  String? managerId;
  String? staffId;
  DateTime? createdAt;
  DateTime? updatedAt;

  CrInfo({
    this.id,
    this.description,
    this.submitDate,
    this.clientApprovedRepair,
    this.completedDate,
    this.denialDate,
    this.reasonForDenial,
    this.costOfCorrection,
    this.managerQuote,
    this.staffQuote,
    this.status,
    this.userId,
    this.managerId,
    this.staffId,
    this.createdAt,
    this.updatedAt,
  });

  factory CrInfo.fromJson(Map<String, dynamic> json) => CrInfo(
        id: json["id"],
        description: json["description"],
        submitDate: json["submit_date"] == null
            ? null
            : DateTime.parse(json["submit_date"]),
        clientApprovedRepair: json["client_approved_repair"],
        completedDate: json["completed_date"],
        denialDate: json["denial_date"],
        reasonForDenial: json["reason_for_denial"],
        costOfCorrection: json["cost_of_correction"],
        managerQuote: json["manager_quote"],
        staffQuote: json["staff_quote"],
        status: json["status"],
        userId: json["user_id"],
        managerId: json["manager_id"],
        staffId: json["staff_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "submit_date":
            "${submitDate!.year.toString().padLeft(4, '0')}-${submitDate!.month.toString().padLeft(2, '0')}-${submitDate!.day.toString().padLeft(2, '0')}",
        "client_approved_repair": clientApprovedRepair,
        "completed_date": completedDate,
        "denial_date": denialDate,
        "reason_for_denial": reasonForDenial,
        "cost_of_correction": costOfCorrection,
        "manager_quote": managerQuote,
        "staff_quote": staffQuote,
        "status": status,
        "user_id": userId,
        "manager_id": managerId,
        "staff_id": staffId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
