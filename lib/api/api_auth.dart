import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:lotuspmc/controller/db_controller.dart';
import 'package:lotuspmc/model/auth/auth_model.dart';
import 'package:lotuspmc/model/auth/singup.dart';
import 'package:lotuspmc/model/common.dart';
import 'package:lotuspmc/model/contact%20us/pm_info.dart';

final dio = Dio();

var baseUrl = 'http://sahedstar.xyz/api';

var headers = {
  "content-type": 'application/json;charset=UTF-8',
  'charset': 'utf-8',
  'Connection': 'keep-alive',
  'Authorization': 'Bearer ${getx.Get.find<DBController>().getUserToken()!}',
};

class ApiServiceLogin {
  static Future<LoginResponseModel?> manualLoginApi(
    LoginModel data,
  ) async {
    try {
      print(data.toJson());
      final response = await dio.post(
        '$baseUrl/login',
        data: loginModelToJson(data),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return loginResponseModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<ResponseModel?> manualRegisterApi(
    SingUpModel data,
  ) async {
    print(data.toJson());
    try {
      final response = await dio.post(
        '$baseUrl/contact-submit',
        data: singUpModelToJson(data),
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return responseModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<PminfoModel?> getPMInfoApi() async {
    try {
      print(
          '$baseUrl/get-pm-info/${getx.Get.find<DBController>().getUserID()!}');
      final response = await dio.get(
        '$baseUrl/get-pm-info/${getx.Get.find<DBController>().getUserID()!}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return pminfoModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }
}
