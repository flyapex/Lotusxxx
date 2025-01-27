import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/api/api_dep.dart';
import 'package:lotuspmc/controller/db_controller.dart';
import 'package:lotuspmc/service/common.dart';
import '../model/dep/send.dart';

String userID = Get.find<DBController>().getUserID()!;

class DepController extends GetxController {
  var selectedDateTime = DateTime.now().obs;

  TextEditingController housekeepingController = TextEditingController();
  TextEditingController automobilesController = TextEditingController();
  TextEditingController trashRecycleController = TextEditingController();
  TextEditingController additionalController = TextEditingController();

  var isDepLoading = false.obs;

  Future<void> sendDep() async {
    try {
      isDepLoading.value = true;

      final depData = DepSendModel(
        date: selectedDateTime.value.toIso8601String().split('T')[0],
        time: selectedDateTime.value
            .toIso8601String()
            .split('T')[1]
            .split('.')[0],
        userId: int.tryParse(userID),
        housekeeping: housekeepingController.text,
        automobiles: automobilesController.text,
        trashRecycle: trashRecycleController.text,
        additional: additionalController.text,
      );

      final response = await ApiServiceDep.depSendApi(depData);

      if (response != null) {
        // clean the text fields
        housekeepingController.clear();
        automobilesController.clear();
        trashRecycleController.clear();
        additionalController.clear();
        selectedDateTime.value = DateTime.now();
        showSnackbar("Success", response.message);
        await Future.delayed(const Duration(seconds: 2));
        Get.back(closeOverlays: true);
      } else {
        showSnackbar("Error", "Failed to send departure notification.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isDepLoading.value = false;
    }
  }
}
