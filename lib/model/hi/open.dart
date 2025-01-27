// To parse this JSON data, do
//
//     final hIreceiveModel = hIreceiveModelFromJson(jsonString);

import 'dart:convert';

HIreceiveModel hIreceiveModelFromJson(String str) =>
    HIreceiveModel.fromJson(json.decode(str));

String hIreceiveModelToJson(HIreceiveModel data) => json.encode(data.toJson());

class HIreceiveModel {
  bool? success;
  String? message;
  Data? data;

  HIreceiveModel({
    this.success,
    this.message,
    this.data,
  });

  factory HIreceiveModel.fromJson(Map<String, dynamic> json) => HIreceiveModel(
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
  List<PiInfo>? piInfos;

  Data({
    this.piInfos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        piInfos: json["piInfos"] == null
            ? []
            : List<PiInfo>.from(
                json["piInfos"]!.map((x) => PiInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "piInfos": piInfos == null
            ? []
            : List<dynamic>.from(piInfos!.map((x) => x.toJson())),
      };
}

class PiInfo {
  int? id;
  String? piNo;
  String? piDesc;
  String? estdCost;
  String? actualCost;
  dynamic completedDate;
  dynamic denialDate;
  dynamic reasonForDenial;
  dynamic ownerReasonForDenial;
  String? status;
  String? isOwnerApproval;
  dynamic clientApprovedRepair;
  String? managerQuote;
  String? staffQuote;
  String? userId;
  String? managerId;
  String? staffId;
  DateTime? createdAt;
  DateTime? updatedAt;

  PiInfo({
    this.id,
    this.piNo,
    this.piDesc,
    this.estdCost,
    this.actualCost,
    this.completedDate,
    this.denialDate,
    this.reasonForDenial,
    this.ownerReasonForDenial,
    this.status,
    this.isOwnerApproval,
    this.clientApprovedRepair,
    this.managerQuote,
    this.staffQuote,
    this.userId,
    this.managerId,
    this.staffId,
    this.createdAt,
    this.updatedAt,
  });

  factory PiInfo.fromJson(Map<String, dynamic> json) => PiInfo(
        id: json["id"],
        piNo: json["pi_no"],
        piDesc: json["pi_desc"],
        estdCost: json["estd_cost"],
        actualCost: json["actual_cost"],
        completedDate: json["completed_date"],
        denialDate: json["denial_date"],
        reasonForDenial: json["reason_for_denial"],
        ownerReasonForDenial: json["owner_reason_for_denial"],
        status: json["status"],
        isOwnerApproval: json["is_owner_approval"],
        clientApprovedRepair: json["client_approved_repair"],
        managerQuote: json["manager_quote"],
        staffQuote: json["staff_quote"],
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
        "pi_no": piNo,
        "pi_desc": piDesc,
        "estd_cost": estdCost,
        "actual_cost": actualCost,
        "completed_date": completedDate,
        "denial_date": denialDate,
        "reason_for_denial": reasonForDenial,
        "owner_reason_for_denial": ownerReasonForDenial,
        "status": status,
        "is_owner_approval": isOwnerApproval,
        "client_approved_repair": clientApprovedRepair,
        "manager_quote": managerQuote,
        "staff_quote": staffQuote,
        "user_id": userId,
        "manager_id": managerId,
        "staff_id": staffId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
