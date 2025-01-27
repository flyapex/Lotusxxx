import 'package:lotuspmc/controller/db_controller.dart';
import 'package:get/get.dart' as getx;

var headers = {
  "content-type": 'application/json;charset=UTF-8',
  'charset': 'utf-8',
  'Connection': 'keep-alive',
  'Authorization': 'Bearer ${getx.Get.find<DBController>().getUserToken()!}',
};
String userID = getx.Get.find<DBController>().getUserID()!;
