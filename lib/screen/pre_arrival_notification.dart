import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/pan_controller.dart';
import 'package:lotuspmc/screen/pre%20arrival%20notification/input.dart';
import 'package:lotuspmc/screen/widget/button.dart';
import 'package:lotuspmc/screen/widget/date_time.dart';
import 'package:lotuspmc/service/style/color.dart';
import 'widget/appbar.dart';
import 'widget/text.dart';

class PreArrivalNotification extends StatefulWidget {
  const PreArrivalNotification({super.key});

  @override
  State<PreArrivalNotification> createState() => _PreArrivalNotificationState();
}

class _PreArrivalNotificationState extends State<PreArrivalNotification> {
  PANController panController = Get.put(PANController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyappBar(
          title: "\nPRE-ARRIVAL NOTIFICATION",
          backgroundColor: mutedText,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleWithBorder(title: 'WELCOME HOME'),
              Text(
                'PLEASE LET US KNOW WHEN YOU WILL BE ARRIVING AT YOUR HOME AND HOW WE MAY BE ABLE TO ASSIST IN GETTING EVERYTHING READY FOR YOUR ARRIVAL.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: secondary,
                ),
              ).paddingSymmetric(vertical: 20),
              CustomDateTimePicker(
                title: "ARRIVAL DATE",
                subtitle: "EST'D ARRIVAL TIME",
                initialDate: DateTime.now(),
                onDateTimeChanged: (DateTime dateTime) {
                  // Handle the selected date-time here
                  debugPrint('Selected DateTime: $dateTime');
                  // selectedDateTime = dateTime;
                  panController.selectedDateTime.value = dateTime;
                },
              ),
              const TitleWithBorder(title: 'ARRIVAL PREFERENCES').paddingOnly(
                top: 20,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: CheckmarkWithTitle(
                      checkMarkTitle: 'OUTDOOR LIGHTS',
                      checkMarkContent: 'All On',
                      onTap: (isChecked) {
                        print(isChecked);
                        panController.outdoorLightsController = isChecked;
                      },
                    ),
                  ),
                  const VerticalDivider(),
                  Flexible(
                    flex: 1,
                    child: CheckmarkWithTitle(
                      checkMarkTitle: 'INDOOR LIGHTS',
                      checkMarkContent: 'All On',
                      onTap: (isChecked) {
                        print(isChecked);
                        panController.indoorLightsController = isChecked;
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 70,
                child: TextFormField(
                  controller: panController.additonalNotesController,
                  decoration: const InputDecoration(
                    labelText: 'Additional Information',
                    border: OutlineInputBorder(),
                  ),
                  expands: true,
                  maxLines: null,
                  minLines: null,
                ).paddingSymmetric(vertical: 8),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SingleInput(
                      title: 'TEMPERATURE SETTINGS',
                      subtitle: '°F',
                      hint: '72',
                      controller: panController.temperatureController,
                    ),
                  ),
                  const VerticalDivider(),
                  Flexible(
                    flex: 1,
                    child: SingleInput(
                      title: 'POOL TEMPERATURE',
                      subtitle: '°F',
                      hint: '0',
                      controller: panController.poolTemperatureController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SingleInput(
                      title: 'HOT TUB TEMPERATURE',
                      subtitle: '°F',
                      hint: '72',
                      controller: panController.hotTubTemperatureController,
                    ),
                  ),
                ],
              ),
              //dropdown
              DropDown(
                onChanged: (p0) {
                  panController.windowBlindsController = p0!;
                },
              ),
              //input fields
              CheckmarkWithInput(
                checkMarkTitle: 'MUSIC',
                checkMarkContent: 'Play Music',
                controllers: [
                  panController.musicController,
                ],
                inputTitles: const [
                  'Music Genre',
                ],
                height: 70,
              ),
              CheckmarkWithInput(
                checkMarkTitle: 'FLOWERS',
                checkMarkContent: 'Order Flowers',
                inputBoxCount: 2,
                controllers: [
                  panController.flowerTypeController,
                  panController.flowerLocationController,
                ],
                inputTitles: const [
                  'Type:',
                  'Location:',
                ],
                height: 70,
              ),
              CheckmarkWithInput(
                checkMarkTitle: 'GROCERIES',
                checkMarkContent: 'Order Groceries',
                height: 90,
                controllers: [
                  panController.groceriesController,
                ],
                inputTitles: const [
                  'Details:',
                ],
              ),
              CheckmarkWithInput(
                checkMarkTitle: 'ALCOHOL',
                checkMarkContent: 'Order Alcohol',
                controllers: [
                  panController.alcoholController,
                ],
                inputTitles: const [
                  'Details:',
                ],
              ),
              CheckmarkWithInput(
                checkMarkTitle: 'HOUSEKEEPING',
                checkMarkContent: 'Require Housekeeping',
                controllers: [
                  panController.housekeepingController,
                ],
                inputTitles: const [
                  'Details:',
                ],
              ),
              CheckmarkWithInput(
                checkMarkTitle: 'TRANSPORTATION',
                checkMarkContent: 'Arrange Transportation',
                controllers: [
                  panController.trnsportationController,
                ],
                inputTitles: const [
                  'Details:',
                ],
              ),
              CheckmarkWithInput(
                checkMarkTitle: 'AUTOMOBILES',
                checkMarkContent: 'Manage Automobiles',
                controllers: [
                  panController.automobileController,
                ],
                inputTitles: const [
                  'Details (Fueled, washed, cleaned, parked in certain location):',
                ],
              ),
              PreArrivalWithInput(
                title: 'Additional Pre-arrival Requests',
                subtitle: 'Add any special requests:',
                controllers: panController.specialRequestsController,
              ),
              Text(
                'FOR ANY ADDITIONAL SPECIAL REQUESTS REGARDING YOUR ARRIVAL, PLEASE ENTER THOSE IN THE CONCIERGE TAB.',
                style: TextStyle(
                  color: secondary,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingSymmetric(vertical: 20),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: SubmitButton(
              //     title: 'CONCIERGE TAB',
              //     onSubmit: () {},
              //   ),
              // ),
              SubmitButton(
                title: "SUBMIT",
                onSubmit: () async {
                  panController.sendPreArivalRequest();
                },
              ),
              const SizedBox(height: 40),
            ],
          ).paddingSymmetric(horizontal: 24),
        ));
  }
}
