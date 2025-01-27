import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lotuspmc/api/common.dart';
import 'package:lotuspmc/model/common.dart';
import 'package:lotuspmc/model/cr/cr_open.dart';
import 'package:lotuspmc/model/cr/cr_send.dart';

final dio = Dio();

var baseUrl = 'http://sahedstar.xyz/api/cr';

class ApiServiceCR {
  static Future<ResponseModel?> crSendApi(
    ConciergeRequestSendModel data,
  ) async {
    try {
      print(data.toJson());
      final response = await dio.post(
        '$baseUrl/cr/submit',
        data: conciergeRequestSendModelToJson(data),
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return responseModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<CRreceiveModel?> crOpenApi() async {
    try {
      final response = await dio.get(
        '$baseUrl/open/$userID',
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return cRreceiveModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<CRreceiveModel?> crCompletedApi() async {
    try {
      final response = await dio.get(
        '$baseUrl/completed/$userID',
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return cRreceiveModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<CRreceiveModel?> crDeniedApi() async {
    try {
      final response = await dio.get(
        '$baseUrl/denied/$userID',
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return cRreceiveModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }
}
