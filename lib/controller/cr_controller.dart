import 'package:get/get.dart';
import 'package:lotuspmc/api/api_cr.dart';
import 'package:lotuspmc/model/cr/cr_open.dart';
import 'package:lotuspmc/model/cr/cr_send.dart';
import 'package:lotuspmc/service/common.dart';

import '../api/common.dart';

class CRController extends GetxController {
  var isconciergeRequestLoading = false.obs;

  Future<void> sendConciergeRequest(String details) async {
    try {
      isconciergeRequestLoading.value = true;

      final data = ConciergeRequestSendModel(
        details: details,
        userId: userID,
      );

      final response = await ApiServiceCR.crSendApi(data);

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
      isconciergeRequestLoading.value = false;
    }
  }

  var crOpenData = Rxn<CRreceiveModel>();
  var isLoading = false.obs;

  void fetchCROpen() async {
    try {
      isLoading.value = true;
      final info = await ApiServiceCR.crOpenApi();
      if (info != null) {
        crOpenData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
  // make it for now crCompletedData

  var crCompletedData = Rxn<CRreceiveModel>();
  var isLoadingCompleted = false.obs;

  void fetchCRCompleted() async {
    try {
      isLoadingCompleted.value = true;
      final info = await ApiServiceCR.crCompletedApi();
      if (info != null) {
        crCompletedData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingCompleted.value = false;
    }
  }
  // make it for CRDeniedData

  var crDeniedData = Rxn<CRreceiveModel>();
  var isLoadingDenied = false.obs;

  void fetchCRDenied() async {
    try {
      isLoadingDenied.value = true;
      final info = await ApiServiceCR.crDeniedApi();
      if (info != null) {
        crDeniedData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingDenied.value = false;
    }
  }
}
