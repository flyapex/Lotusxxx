import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:lotuspmc/controller/db_controller.dart';
import 'package:lotuspmc/model/common.dart';
import 'package:lotuspmc/model/dep/send.dart';

final dio = Dio();

var baseUrl = 'http://sahedstar.xyz/api';

var headers = {
  "content-type": 'application/json;charset=UTF-8',
  'charset': 'utf-8',
  'Connection': 'keep-alive',
  'Authorization': 'Bearer ${getx.Get.find<DBController>().getUserToken()!}',
};

String userID = getx.Get.find<DBController>().getUserID()!;

class ApiServiceDep {
  static Future<ResponseModel?> depSendApi(
    DepSendModel data,
  ) async {
    try {
      // data as params
      print("Request Payload: ${data.toJson()}");
      final response = await dio.post(
        '$baseUrl/departure-submit',
        data: depSendModelToJson(data),
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
}
