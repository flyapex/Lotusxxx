import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/cr_controller.dart';
import 'package:lotuspmc/service/style/color.dart';
import 'widget/appbar.dart';
import 'widget/input.dart';
import 'widget/text.dart';

class ConciergeRequestScreen extends StatefulWidget {
  const ConciergeRequestScreen({super.key});

  @override
  State<ConciergeRequestScreen> createState() => _ConciergeRequestScreenState();
}

class _ConciergeRequestScreenState extends State<ConciergeRequestScreen> {
  CRController crController = Get.find();
  final TextEditingController detailsController = TextEditingController();

  final List<String> services = [
    'VEHICLE DETAILING',
    'TRANSPORTATION SERVICE',
    'FLORAL DELIVERY',
    'TRAVEL ARRANGEMENTS',
    'CULINARY SERVICES',
    'PRIVATE CHARTERS',
    'EVENT PLANNING',
    'IT SUPPORT',
    'CONCIERGE MEDICINE',
  ];

  String? selectedService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nCONCIERGE REQUEST",
        backgroundColor: infoColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lotus has strategic alliances with a host of concierge focused companies that are at your full disposal. Click here for a complete list of offerings and let us know in the area below how we can assist.\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
            ).paddingSymmetric(vertical: 20),
            const TitleWithBorder(title: 'SAMPLE SERVICES'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: services.map((service) {
                final isSelected = selectedService == service;
                return ChoiceChip(
                  label: Text(service),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedService = selected ? service : null;
                    });
                  },
                  selectedColor: primary,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : secondary,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                );
              }).toList(),
            ),
            Text(
              'SPECIFIC REQUESTS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
            ).paddingOnly(top: 20, bottom: 10),
            Obx(
              () {
                return BigInputBox(
                  title: crController.isconciergeRequestLoading.value
                      ? "Submitting..."
                      : "SUBMIT",
                  controller: detailsController,
                  onSubmit: () async {
                    if (detailsController.text.isEmpty) {
                      // ||    selectedService == null

                      Get.snackbar(
                        'Error',
                        'Please enter details.',
                        snackPosition: SnackPosition.TOP,
                        borderRadius: 10,
                        margin: const EdgeInsets.all(10),
                      );
                      return;
                    }

                    await crController.sendConciergeRequest(
                      detailsController.text.trim(),
                    );
                    detailsController.clear();
                  },
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }
}
