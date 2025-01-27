import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/api/api_pan.dart';
import 'package:lotuspmc/model/pan/send.dart';
import 'package:lotuspmc/service/common.dart';

import 'db_controller.dart';

String userID = Get.find<DBController>().getUserID()!;

class PANController extends GetxController {
  var selectedDateTime = DateTime.now().obs;

  bool outdoorLightsController = false;
  bool indoorLightsController = false;
  TextEditingController additonalNotesController = TextEditingController();
  TextEditingController temperatureController =
      TextEditingController(text: '0');
  TextEditingController poolTemperatureController = TextEditingController(
    text: '0',
  );
  TextEditingController hotTubTemperatureController = TextEditingController(
    text: '0',
  );
  String windowBlindsController = '';
  TextEditingController musicController = TextEditingController();
  TextEditingController flowerTypeController = TextEditingController();
  TextEditingController flowerLocationController = TextEditingController();
  TextEditingController groceriesController = TextEditingController();
  TextEditingController alcoholController = TextEditingController();
  TextEditingController housekeepingController = TextEditingController();
  TextEditingController trnsportationController = TextEditingController();
  TextEditingController automobileController = TextEditingController();
  TextEditingController specialRequestsController = TextEditingController();

  var isLoading = false.obs;

  Future<void> sendPreArivalRequest() async {
    try {
      isLoading.value = true;
      final data = PanSendModel(
        date: selectedDateTime.value.toIso8601String().split('T')[0],
        time: selectedDateTime.value
            .toIso8601String()
            .split('T')[1]
            .split('.')[0],
        temperature: int.parse(temperatureController.text),
        windowBlinds: windowBlindsController,
        outdoorLights: outdoorLightsController,
        indoorLights: indoorLightsController,
        indoorLightInfo: additonalNotesController.text,
        poolTemperature: poolTemperatureController.text,
        tubTemperature: hotTubTemperatureController.text,
        musicGenre: musicController.text,
        flowerType: flowerTypeController.text,
        flowerLocation: flowerLocationController.text,
        groceryList: groceriesController.text,
        alcoholList: alcoholController.text,
        housekeepingDetails: housekeepingController.text,
        transportationDetails: trnsportationController.text,
        automobileDetails: automobileController.text,
        specialRequests: specialRequestsController.text,
        userId: userID,
      );

      final response = await ApiServicePAN.panSendApi(data);

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
      isLoading.value = false;
    }
  }
}
