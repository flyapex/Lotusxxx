// To parse this JSON data, do
//
//     final srReciveModel = srReciveModelFromJson(jsonString);

import 'dart:convert';

SrReciveModel srReciveModelFromJson(String str) =>
    SrReciveModel.fromJson(json.decode(str));

String srReciveModelToJson(SrReciveModel data) => json.encode(data.toJson());

class SrReciveModel {
  bool? success;
  String? message;
  Data? data;

  SrReciveModel({
    this.success,
    this.message,
    this.data,
  });

  factory SrReciveModel.fromJson(Map<String, dynamic> json) => SrReciveModel(
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
  List<SrInfo>? srInfos;

  Data({
    this.srInfos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        srInfos: json["srInfos"] == null
            ? []
            : List<SrInfo>.from(
                json["srInfos"]!.map((x) => SrInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "srInfos": srInfos == null
            ? []
            : List<dynamic>.from(srInfos!.map((x) => x.toJson())),
      };
}

class SrInfo {
  int? id;
  String? srType;
  DateTime? submitDate;
  String? lastActionDesc;
  String? propertyGrounds;
  String? residenceExterior;
  String? residenceInterior;
  String? roomDesignation;
  String? housekeeping;
  String? stormPreparedness;
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

  SrInfo({
    this.id,
    this.srType,
    this.submitDate,
    this.lastActionDesc,
    this.propertyGrounds,
    this.residenceExterior,
    this.residenceInterior,
    this.roomDesignation,
    this.housekeeping,
    this.stormPreparedness,
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

  factory SrInfo.fromJson(Map<String, dynamic> json) => SrInfo(
        id: json["id"],
        srType: json["sr_type"],
        submitDate: json["submit_date"] == null
            ? null
            : DateTime.parse(json["submit_date"]),
        lastActionDesc: json["last_action_desc"],
        propertyGrounds: json["property_grounds"],
        residenceExterior: json["residence_exterior"],
        residenceInterior: json["residence_interior"],
        roomDesignation: json["room_designation"],
        housekeeping: json["housekeeping"],
        stormPreparedness: json["storm_preparedness"],
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
        "sr_type": srType,
        "submit_date":
            "${submitDate!.year.toString().padLeft(4, '0')}-${submitDate!.month.toString().padLeft(2, '0')}-${submitDate!.day.toString().padLeft(2, '0')}",
        "last_action_desc": lastActionDesc,
        "property_grounds": propertyGrounds,
        "residence_exterior": residenceExterior,
        "residence_interior": residenceInterior,
        "room_designation": roomDesignation,
        "housekeeping": housekeeping,
        "storm_preparedness": stormPreparedness,
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
