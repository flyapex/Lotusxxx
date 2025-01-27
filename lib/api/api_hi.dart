import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:lotuspmc/controller/db_controller.dart';
import 'package:lotuspmc/model/common.dart';
import 'package:lotuspmc/model/hi/open.dart';
import 'package:lotuspmc/model/hi/send.dart';

final dio = Dio();

var baseUrl = 'http://sahedstar.xyz/api/home-improvement';

var headers = {
  "content-type": 'application/json;charset=UTF-8',
  'charset': 'utf-8',
  'Connection': 'keep-alive',
  'Authorization': 'Bearer ${getx.Get.find<DBController>().getUserToken()!}',
};

String userID = getx.Get.find<DBController>().getUserID()!;

class ApiServiceHI {
  // static Future<ResponseModel?> crSendApi(
  //   data,
  // ) async {
  //   try {
  //     print(data.toJson());
  //     final response = await dio.post(
  //       '$baseUrl/submit',
  //       data: conciergeRequestSendModelToJson(data),
  //       options: Options(headers: headers),
  //     );
  //     print(response.data);
  //     if (response.statusCode == 200) {
  //       return responseModelFromJson(jsonEncode(response.data));
  //     }
  //     return null;
  //   } catch (e) {
  //     print("Unexpected Error: $e");
  //     return null;
  //   }
  // }

  static Future<ResponseModel?> hiSendApi(
    HiSendModel data,
  ) async {
    try {
      print(data.toJson());
      final response = await dio.post(
        '$baseUrl/submit',
        data: hiSendModelToJson(data),
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

  static Future<HIreceiveModel?> hiOpenApi() async {
    try {
      final response = await dio.get(
        '$baseUrl/open/$userID',
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return hIreceiveModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<ResponseModel?> hiApprovedApi(
    int id,
  ) async {
    try {
      final response = await dio.post(
        '$baseUrl/approve/$id',
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

  static Future<ResponseModel?> hiDenyApi(int id, String reason) async {
    try {
      final response = await dio.post('$baseUrl/deny/$id',
          options: Options(headers: headers),
          data: {"owner_reason_for_denial": reason});
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

  static Future<HIreceiveModel?> hiCompleteProjectApi() async {
    try {
      final response = await dio.get(
        '$baseUrl/completed/$userID',
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return hIreceiveModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }
}
