import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/api/api_sr.dart';
import 'package:lotuspmc/api/common.dart';
import 'package:lotuspmc/model/sr/sr_open.dart';
import 'package:lotuspmc/model/sr/sr_room.dart';
import 'package:lotuspmc/model/sr/sr_send.dart';
import 'package:lotuspmc/screen/home.dart';
import 'package:lotuspmc/service/common.dart';

class SRController extends GetxController {
  final RxString requestType = ''.obs;
  TextEditingController propertyGroundsController = TextEditingController();
  TextEditingController residenceExteriorController = TextEditingController();
  TextEditingController residenceInteriorController = TextEditingController();
  String roomDesignation = '';
  TextEditingController housekeepingController = TextEditingController();
  TextEditingController stormPreparednessController = TextEditingController();
  TextEditingController additionalDetailsController = TextEditingController();
  var isSRLoadingSend = false.obs;

  Future<void> sendSRRequest() async {
    try {
      isSRLoadingSend.value = true;

      final data = SrSendModel(
        srType: requestType.value,
        details: additionalDetailsController.text,
        userId: userID,
        roomDesignation: roomDesignation,
      );

      final response = await ApiServiceSR.srSendApi(data);

      if (response != null) {
        showSnackbar("Success", response.message);
        await Future.delayed(const Duration(seconds: 2));
        // Get.back(closeOverlays: true);
        Get.dialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Thank you for your request. Your CM will contact you if we have further questions. Otherwise, we are on it.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFFFFFFFF),
                                backgroundColor: Colors.amber,
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'New Service Request',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFFFFFFFF),
                                backgroundColor: Colors.amber,
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.to(() => const HomeScreen());
                              },
                              child: const Text(
                                "I'm Finished",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).paddingAll(20),
              ).paddingSymmetric(horizontal: 40),
            ],
          ),
        );
      } else {
        showSnackbar("Error", "Failed to send concierge request.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isSRLoadingSend.value = false;
    }
  }

  var srOpenData = Rxn<SrReciveModel>();
  var isLoading = false.obs;

  void fetchSROpen() async {
    try {
      isLoading.value = true;
      final info = await ApiServiceSR.srOpenApi();
      if (info != null) {
        srOpenData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  var srCompletedData = Rxn<SrReciveModel>();
  var isLoadingCompleted = false.obs;

  void fetchSRCompleted() async {
    try {
      isLoadingCompleted.value = true;
      final info = await ApiServiceSR.srCompletedApi();
      if (info != null) {
        srCompletedData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingCompleted.value = false;
    }
  }

  var srDeniedData = Rxn<SrReciveModel>();
  var isLoadingDenied = false.obs;

  void fetchSRDenied() async {
    try {
      isLoadingDenied.value = true;
      final info = await ApiServiceSR.srDeniedApi();
      if (info != null) {
        srDeniedData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingDenied.value = false;
    }
  }

  // make it for getRoom
  var roomData = Rxn<RoomModel>();
  var isLoadingRoom = false.obs;

  void fetchRoom() async {
    try {
      isLoadingRoom.value = true;
      final info = await ApiServiceSR.srGetRoomApi();
      if (info != null) {
        roomData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingRoom.value = false;
    }
  }
}
