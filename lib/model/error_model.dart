// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) =>
    ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) =>
    json.encode(data.toJson());

class ErrorResponseModel {
  bool success;
  String message;
  Data data;

  ErrorResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  ErrorResponseModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      ErrorResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String error;

  Data({
    required this.error,
  });

  Data copyWith({
    String? error,
  }) =>
      Data(
        error: error ?? this.error,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}
