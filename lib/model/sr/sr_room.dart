// To parse this JSON data, do
//
//     final roomModel = roomModelFromJson(jsonString);

import 'dart:convert';

RoomModel roomModelFromJson(String str) => RoomModel.fromJson(json.decode(str));

String roomModelToJson(RoomModel data) => json.encode(data.toJson());

class RoomModel {
  bool? success;
  String? message;
  List<String>? data;

  RoomModel({
    this.success,
    this.message,
    this.data,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<String>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
