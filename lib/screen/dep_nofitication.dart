import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/dep_controller.dart';
import 'package:lotuspmc/screen/widget/input.dart';
import 'package:lotuspmc/service/style/color.dart';

import 'widget/appbar.dart';
import 'widget/button.dart';
import 'widget/date_time.dart';
import 'widget/text.dart';

class DepartureNofiticationScreen extends StatelessWidget {
  const DepartureNofiticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DepController depController = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nDEPARTURE NOTIFICATION",
        backgroundColor: borderColor,
      ),
      body: Obx(
        () {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleWithBorder(title: 'WELCOME HOME'),
                Text(
                  'PLEASE LET US KNOW WHEN YOU EXPECT TO BE DEPARTING AND IF THERE IS ANYTHING WE CAN ASSIST YOU WITH OR ITEMS NEEDING ATTENTION FOLLOWING YOUR DEPARTURE.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: secondary,
                  ),
                ).paddingSymmetric(vertical: 20),
                CustomDateTimePicker(
                  title: "ARRIVAL DATE",
                  subtitle: "DEPARTURE TIME",
                  initialDate: depController.selectedDateTime.value,
                  onDateTimeChanged: (DateTime selectedDateTime) {
                    depController.selectedDateTime.value = selectedDateTime;
                  },
                ),
                SmallInputBox(
                  controller: depController.housekeepingController,
                  title: 'Housekeeping (wash / remake beds, etc.)',
                  maxLines: 2,
                  onSubmit: () {},
                ).paddingSymmetric(vertical: 20),
                SmallInputBox(
                  controller: depController.automobilesController,
                  title: 'Wash / Refuel Automobiles',
                  maxLines: 2,
                  onSubmit: () {},
                ).paddingSymmetric(vertical: 20),
                SmallInputBox(
                  controller: depController.trashRecycleController,
                  title: 'Trash / Recycle Removal',
                  maxLines: 2,
                  onSubmit: () {},
                ).paddingSymmetric(vertical: 20),
                SmallInputBox(
                  controller: depController.additionalController,
                  title: 'Additional',
                  maxLines: 2,
                  onSubmit: () {},
                ).paddingSymmetric(vertical: 20),
                SubmitButton(
                  title: depController.isDepLoading.value
                      ? "Submitting..."
                      : "SUBMIT",
                  onSubmit: () async {
                    if (!depController.isDepLoading.value) {
                      depController.sendDep();
                    }
                  },
                ),
                const SizedBox(height: 40),

                // SubmitButton(title: 'SEND US A MESSAGE', onSubmit: () {}),
                // SubmitButton(title: 'ENTER A SERVICE REQUEST', onSubmit: () {}),
              ],
            ).paddingSymmetric(horizontal: 24),
          );
        },
      ),
    );
  }
}
