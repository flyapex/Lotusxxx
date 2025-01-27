import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/api/api_hi.dart';
import 'package:lotuspmc/model/hi/open.dart';
import 'package:lotuspmc/model/hi/send.dart';
import 'package:lotuspmc/service/common.dart';

class HIController extends GetxController {
  var isLoadingSend = false.obs;

  Future<void> sendHIRequest(String details) async {
    try {
      isLoadingSend.value = true;

      final data = HiSendModel(
        details: details,
        userId: userID,
      );

      final response = await ApiServiceHI.hiSendApi(data);

      if (response != null) {
        showSnackbar("Success", response.message);
        await Future.delayed(const Duration(seconds: 2));
        Get.back(closeOverlays: true);
      } else {
        showSnackbar("Error", "Failed to send concierge request.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingSend.value = false;
    }
  }

  var hiOpenData = Rxn<HIreceiveModel>();
  var isLoadingOpen = false.obs;

  void fetchHIOpen() async {
    try {
      isLoadingOpen.value = true;
      final info = await ApiServiceHI.hiOpenApi();
      if (info != null) {
        hiOpenData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingOpen.value = false;
    }
  }

  var isLoadingApproved = false.obs;

  void hiApproved(id) async {
    try {
      isLoadingApproved.value = true;
      final response = await ApiServiceHI.hiApprovedApi(id);
      if (response != null) {
        showSnackbar("Success", response.message);
        await Future.delayed(const Duration(seconds: 2));
        Get.back(closeOverlays: true);
      } else {
        showSnackbar("Error", "Failed to send departure notification.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingApproved.value = false;
    }
  }

  TextEditingController hidenyController = TextEditingController();
  var isLoadingDeny = false.obs;

  void hiDeny(id) async {
    try {
      isLoadingDeny.value = true;
      final response = await ApiServiceHI.hiDenyApi(id, hidenyController.text);
      if (response != null) {
        showSnackbar("Success", response.message);
        // await Future.delayed(const Duration(seconds: 2));
        // Get.back(closeOverlays: true);
      } else {
        showSnackbar("Error", "Failed to send departure notification.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingDeny.value = false;
    }
  }

  var hiCompleteProjectData = Rxn<HIreceiveModel>();
  var isLoadingCompleteProject = false.obs;

  void fetchHICompleteProject() async {
    try {
      isLoadingCompleteProject.value = true;
      final info = await ApiServiceHI.hiCompleteProjectApi();
      if (info != null) {
        hiCompleteProjectData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingCompleteProject.value = false;
    }
  }
}
