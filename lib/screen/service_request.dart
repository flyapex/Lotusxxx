import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/property_controller.dart';
import 'package:lotuspmc/controller/sr_controller.dart';
import 'package:lotuspmc/screen/sr/dropdown.dart';
import 'package:lotuspmc/screen/widget/cart.dart';
import 'package:lotuspmc/screen/widget/input.dart';
import 'package:lotuspmc/service/common.dart';
import '../service/style/color.dart';
import 'widget/appbar.dart';
import 'widget/text.dart';

class ServiceRequestScreen extends StatelessWidget {
  final SRController srController = Get.put(SRController());
  final PropertyController propertyController = Get.find();
  ServiceRequestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    srController.fetchRoom();
    propertyController.fetchPropertyInformation();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nSERVICE REQUEST",
        backgroundColor: accentBackground,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'Please send a brief description of how we can assist. For Interior requests, please refer to your floor plan and note the room designation on your Interior Request so that we will know where the item is.',
              style: TextStyle(
                color: secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.dialog(
                    Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Floor Plan',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).paddingSymmetric(vertical: 10),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () => Get.back(),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 20),
                            SizedBox(
                              width: Get.width * 0.9,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Obx(() {
                                          if (propertyController
                                              .isLoading.value) {
                                            return Center(child: loadingData());
                                          }
                                          final property = propertyController
                                              .propertyInfo.value?.data;
                                          if (property == null ||
                                              property.floors == null ||
                                              property.floors!.isEmpty) {
                                            return Center(child: noData());
                                          }
                                          return GridView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: property.floors!.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 0.6,
                                            ),
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final floor =
                                                  property.floors![index];
                                              return CartContainer(
                                                label: floor.floorName ?? 'N/A',
                                                image:
                                                    floor.floorImage ?? 'N/A',
                                              );
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ).paddingSymmetric(horizontal: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Click here to view floor plan',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const TitleWithBorder(title: 'SUBMIT REQUEST'),
            const Text(
              'IDENTIFY YOUR REQUEST TYPE(*)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ).paddingSymmetric(vertical: 5),
            Obx(
              () => Column(
                children: [
                  _buildRadioTile(
                      "Interior Residence", srController.requestType),
                  _buildRadioTile(
                      "Exterior Structure", srController.requestType),
                  _buildRadioTile("Exterior Grounds", srController.requestType),
                  _buildRadioTile("Housekeeping", srController.requestType),
                  _buildRadioTile("Water Features", srController.requestType),
                  _buildRadioTile(
                      "Storm Preparedness", srController.requestType),
                  _buildRadioTile("Other", srController.requestType),
                ],
              ),
            ),
            Obx(() {
              // if (srController.roomData.value == null) {
              //   return Container();
              // }
              if (srController.requestType.value == "Interior Residence") {
                {
                  return DropDownRoom(
                    items: srController.roomData.value!.data!.toList(),
                    onChanged: (value) {
                      srController.roomDesignation = value;
                    },
                  );
                }
              }
              return Container();
            }),
            const SizedBox(height: 20.0),
            BigInputBox(
              controller: srController.additionalDetailsController,
              hint: 'SR Information (*)',
              onSubmit: () async {
                final type = srController.requestType.value;
                final additionalDetails =
                    srController.additionalDetailsController.text.trim();

                if (type.isEmpty) {
                  showSnackbar(
                    "Error",
                    "Please Select Service Request Type",
                  );
                  return;
                }

                if (additionalDetails.isEmpty) {
                  showSnackbar(
                    "Error",
                    "Please Provide Sr Information",
                  );
                  return;
                }

                if (type == "Interior Residence" &&
                    srController.roomDesignation.isEmpty) {
                  showSnackbar(
                    "Error",
                    "Please Select Room Designation",
                  );
                  return;
                }

                // Proceed to send the request
                await srController.sendSRRequest();
                srController.additionalDetailsController.clear();
                srController.requestType.value = '';
                srController.roomDesignation = '';
              },
            ),
            const SizedBox(height: 40),
            Obx(
              () => srController.isSRLoadingSend.value
                  ? loadingData()
                  : Container(),
            ),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }

  Widget _buildRadioTile(String title, RxString groupValue) {
    return RadioListTile<String>(
      visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      title: Text(title),
      value: title,
      groupValue: groupValue.value,
      contentPadding: EdgeInsets.zero,
      onChanged: (value) {
        groupValue.value = value!;
      },
    );
  }
}
