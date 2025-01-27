// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart' as getx;
// import 'package:lotuspmc/controller/db_controller.dart';
// import 'package:lotuspmc/model/sr/sr_open.dart';

// final dio = Dio();

// var baseUrl = 'http://sahedstar.xyz/api/sr';

// var headers = {
//   "content-type": 'application/json;charset=UTF-8',
//   'charset': 'utf-8',
//   'Connection': 'keep-alive',
//   'Authorization': 'Bearer ${getx.Get.find<DBController>().getUserToken()!}',
// };

// String userID = getx.Get.find<DBController>().getUserID()!;

// class ApiServiceCR {
//   // static Future<ResponseModel?> crSendApi(
//   //   ConciergeRequestSendModel data,
//   // ) async {
//   //   try {
//   //     print(data.toJson());
//   //     final response = await dio.post(
//   //       '$baseUrl/cr/submit',
//   //       data: conciergeRequestSendModelToJson(data),
//   //       options: Options(headers: headers),
//   //     );
//   //     print(response.data);
//   //     if (response.statusCode == 200) {
//   //       return responseModelFromJson(jsonEncode(response.data));
//   //     }
//   //     return null;
//   //   } catch (e) {
//   //     print("Unexpected Error: $e");
//   //     return null;
//   //   }
//   // }

//   static Future<SrReciveModel?> crOpenApi() async {
//     try {
//       final response = await dio.get(
//         '$baseUrl/open/$userID',
//         options: Options(headers: headers),
//       );
//       print(response.data);
//       if (response.statusCode == 200) {
//         return srReciveModelFromJson(jsonEncode(response.data));
//       }
//       return null;
//     } catch (e) {
//       print("Unexpected Error: $e");
//       return null;
//     }
//   }

//   static Future<SrReciveModel?> srCompletedApi() async {
//     try {
//       final response = await dio.get(
//         '$baseUrl/completed/$userID',
//         options: Options(headers: headers),
//       );
//       print(response.data);
//       if (response.statusCode == 200) {
//         return srReciveModelFromJson(jsonEncode(response.data));
//       }
//       return null;
//     } catch (e) {
//       print("Unexpected Error: $e");
//       return null;
//     }
//   }

//   static Future<SrReciveModel?> srDeniedApi() async {
//     try {
//       final response = await dio.get(
//         '$baseUrl/denied/$userID',
//         options: Options(headers: headers),
//       );
//       print(response.data);
//       if (response.statusCode == 200) {
//         return srReciveModelFromJson(jsonEncode(response.data));
//       }
//       return null;
//     } catch (e) {
//       print("Unexpected Error: $e");
//       return null;
//     }
//   }
// }
