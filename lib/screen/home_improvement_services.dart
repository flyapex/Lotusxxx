import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/hi_controller.dart';
import 'package:lotuspmc/service/style/color.dart';
import 'widget/appbar.dart';
import 'widget/input.dart';
import 'widget/text.dart';

class HomeImprovementServicesScreen extends StatefulWidget {
  const HomeImprovementServicesScreen({super.key});

  @override
  State<HomeImprovementServicesScreen> createState() =>
      _HomeImprovementServicesScreenState();
}

class _HomeImprovementServicesScreenState
    extends State<HomeImprovementServicesScreen> {
  HIController hiController = Get.find();

  final TextEditingController detailsController = TextEditingController();

  final List<String> services = [
    "Interior/Exterior Renovations",
    "Architectural & Engineering Services",
    "Interior Design Services",
    "Pool Repairs, Resurfacing, etc.",
    "Landscaping",
    "Home Automation",
    "Mechanical/Electrical/Plumbing",
    "Window Treatment",
    "Patio/Pavers",
    "Fencing/Gating",
    "Flooring Replacement & Repairs",
    "Window Replacement",
    "Closet Systems",
    "Security Systems",
    "Lighting"
  ];

  final List<String> selectedServices = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nHOME IMPROVEMENT SERVICES",
        backgroundColor: successColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lotus PMC has strategic alliances with several construction and home improvement companies and can serve as your project manager for any services that you may need. Services include but are not limited to:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
            ).paddingSymmetric(vertical: 20),
            const TitleWithBorder(title: 'SAMPLE SERVICES'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: services.map((service) {
                final isSelected = selectedServices.contains(service);
                return ChoiceChip(
                  label: Text(service),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      isSelected
                          ? selectedServices.remove(service)
                          : selectedServices.add(service);
                    });
                  },
                  selectedColor: primary,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : secondary,
                  ),

                  // shape: RoundedRectangleBorder(
                  //   side: const BorderSide(color: Colors.white),
                  //   borderRadius: BorderRadius.circular(8.0),
                  // ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                );
              }).toList(),
            ),
            Text(
              'INTERESTED IN A SPECIAL PROJECT? TELL US A BIT MORE AND WE WILL REACH OUT.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
            ).paddingOnly(top: 20, bottom: 10),
            const SizedBox(height: 10),
            Obx(() {
              return BigInputBox(
                title: hiController.isLoadingSend.value
                    ? "Submitting..."
                    : "SUBMIT",
                controller: detailsController,
                onSubmit: () async {
                  if (detailsController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please enter details.',
                      snackPosition: SnackPosition.TOP,
                      borderRadius: 10,
                      margin: const EdgeInsets.all(10),
                    );
                    return;
                  }
                  await hiController.sendHIRequest(
                    detailsController.text.trim(),
                  );
                  detailsController.clear();
                },
              );
            }),
            const SizedBox(height: 40),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }
}
