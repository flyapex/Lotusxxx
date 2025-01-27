import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lotuspmc/controller/db_controller.dart';
import 'package:lotuspmc/model/wt/wt_all.dart';
import 'package:lotuspmc/model/wt/wt_complete.dart';
import 'package:lotuspmc/model/wt/wt_denied.dart';
import 'package:lotuspmc/model/wt/wt_open.dart';
import 'package:get/get.dart' as getx;

var headers = {
  "content-type": 'application/json;charset=UTF-8',
  'charset': 'utf-8',
  'Connection': 'keep-alive',
  'Authorization': 'Bearer ${getx.Get.find<DBController>().getUserToken()!}',
};
String userID = getx.Get.find<DBController>().getUserID()!;

final dio = Dio();

var baseUrl = 'http://sahedstar.xyz/api/report';

class ApiServiceWT {
  static Future<WtAllModel?> wtAllApi() async {
    try {
      final response = await dio.get(
        '$baseUrl/all/$userID',
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return wtAllModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<String?> wtGetExcelApi(int reportID) async {
    print('Fetching Excel file for report: $reportID');
    try {
      final response = await dio.get(
        '$baseUrl/generate/$reportID',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Accept':
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            "content-type": 'application/json;charset=UTF-8',
            'charset': 'utf-8',
            'Connection': 'keep-alive',
            'Authorization':
                'Bearer ${getx.Get.find<DBController>().getUserToken()!}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final directory = Directory('/storage/emulated/0/Download');

        // Ensure directory exists
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        final filePath = '${directory.path}/report_$reportID.xlsx';
        final file = File(filePath);

        await file.writeAsBytes(response.data);

        print('Excel file saved successfully at: $filePath');
        return filePath;
      } else {
        print(
            'Failed to fetch the Excel file. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("Unexpected Error while fetching Excel file: $e");
      return null;
    }
  }

  static Future<WtOpenModel?> wtOpenApi() async {
    try {
      final response = await dio.get(
        '$baseUrl/open/$userID',
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return wtOpenModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<WtCompletedModel?> wtCompletedApi() async {
    try {
      final response = await dio.get(
        '$baseUrl/completed/$userID',
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return wtCompletedModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<WtDeniedModel?> wtDeniedApi() async {
    try {
      final response = await dio.get(
        '$baseUrl/denied/$userID',
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return wtDeniedModelFromJson(jsonEncode(response.data));
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }
}
