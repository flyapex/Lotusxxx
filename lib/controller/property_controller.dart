import 'package:get/get.dart';
import 'package:lotuspmc/api/api_property.dart';
import 'package:lotuspmc/model/porperty_info_model.dart';
import 'package:lotuspmc/service/common.dart';

import 'db_controller.dart';
import 'package:get/get.dart' as getx;

String userID = getx.Get.find<DBController>().getUserID()!;

class PropertyController extends GetxController {
  var propertyInfo = Rxn<PropertyInformationResponse>();
  var isLoading = false.obs;

  void fetchPropertyInformation() async {
    try {
      isLoading.value = true;
      final info =
          await ApiServiceProperty.propertyInformationApi(int.parse(userID));
      if (info != null) {
        propertyInfo.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
