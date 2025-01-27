import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:lotuspmc/controller/db_controller.dart';
import 'package:lotuspmc/model/porperty_info_model.dart';

final dio = Dio();

var baseUrl = 'http://sahedstar.xyz/api';

var headers = {
  "content-type": 'application/json;charset=UTF-8',
  'charset': 'utf-8',
  'Connection': 'keep-alive',
  'Authorization': 'Bearer ${getx.Get.find<DBController>().getUserToken()!}',
};

class ApiServiceProperty {
  static Future<PropertyInformationResponse?> propertyInformationApi(
    int propertyId,
  ) async {
    try {
      print('$baseUrl/get-tenant-property/$propertyId');
      print(getx.Get.find<DBController>().getUserToken()!);
      final response = await dio.get(
        '$baseUrl/get-tenant-property/$propertyId',
        options: Options(headers: headers),
      );
      print('-------------------------------');
      print(response.data);
      print('-------------------------------');

      if (response.statusCode == 200) {
        return propertyInformationResponseFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }
}
