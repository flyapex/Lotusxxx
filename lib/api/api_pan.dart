import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lotuspmc/api/common.dart';
import 'package:lotuspmc/model/common.dart';
import 'package:lotuspmc/model/pan/send.dart';

final dio = Dio();

var baseUrl = 'http://sahedstar.xyz/api';

class ApiServicePAN {
  static Future<ResponseModel?> panSendApi(
    PanSendModel data,
  ) async {
    print(
      data.toJson(),
    );
    try {
      print(data.toJson());
      final response = await dio.post(
        '$baseUrl/pre-arrival-submit',
        data: panSendModelToJson(data),
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
