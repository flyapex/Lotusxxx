import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/cr_controller.dart';
import 'package:lotuspmc/controller/db_controller.dart';
import 'package:lotuspmc/controller/dep_controller.dart';
import 'package:lotuspmc/controller/hi_controller.dart';
import 'package:lotuspmc/controller/property_controller.dart';
import 'package:lotuspmc/controller/sr_controller.dart';
import 'package:lotuspmc/controller/user_controller.dart';
import 'package:lotuspmc/controller/wt_controller.dart';
import 'package:lotuspmc/screen/contact.dart';
import 'package:lotuspmc/screen/property_info.dart';
import 'package:lotuspmc/screen/service_request.dart';
import 'package:lotuspmc/service/style/color.dart';

import 'concierge_request.dart';
import 'dep_nofitication.dart';
import 'documents.dart';
import 'home_improvement_services.dart';
import 'pre_arrival_notification.dart';
import 'widget/button.dart';
import 'widget/text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => PropertyController());
    // Get.lazyPut(() => CRController());
    // Get.lazyPut(() => DepController());
    // Get.lazyPut(() => HIController());
    // ignore: unused_local_variable
    final PropertyController propertyController = Get.put(PropertyController());
    // ignore: unused_local_variable
    final CRController crController = Get.put(CRController());
    // ignore: unused_local_variable
    final DepController depController = Get.put(DepController());
    // ignore: unused_local_variable
    final HIController hiController = Get.put(HIController());
    // ignore: unused_local_variable
    final SRController srController = Get.put(SRController());
    // ignore: unused_local_variable
    final WTController wtController = Get.put(WTController());
    // ignore: unused_local_variable
    final UserController userController = Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Image.asset(
              'assets/images/logo.png',
              height: 70,
            ),
            const SizedBox(height: 26),
            Text(
              'WELCOME ${Get.find<DBController>().getUserName()!.toUpperCase()}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const TitleWithBorder(title: 'PROPERTY / CLIENT INFORMATION'),
            ActionButton(
              text: 'PROPERTY / CLIENT INFORMATION',
              color: lightBackground,
              onTap: () {
                Get.to(() => const PropertyInformationScreen());
              },
            ),
            ActionButton(
              text: 'SERVICE REQUEST',
              color: accentBackground,
              onTap: () {
                Get.to(() => ServiceRequestScreen());
              },
            ),
            ActionButton(
              text: 'DOCUMENTS',
              color: highlightColor,
              onTap: () {
                Get.to(() => const DocumentsScreen());
              },
            ),
            const SizedBox(height: 30),
            const TitleWithBorder(title: 'CONCIERGE SERVICES'),
            ActionButton(
              text: 'CONCIERGE REQUEST',
              color: infoColor,
              onTap: () {
                Get.to(() => const ConciergeRequestScreen());
              },
            ),
            ActionButton(
              text: 'PRE-ARRIVAL NOTIFICATION',
              color: mutedText,
              onTap: () {
                Get.to(() => const PreArrivalNotification());
              },
            ),
            ActionButton(
              text: 'DEPARTURE NOTIFICATION & REFRESH',
              color: borderColor,
              onTap: () {
                Get.to(() => const DepartureNofiticationScreen());
              },
            ),
            const SizedBox(height: 30),
            const TitleWithBorder(title: 'HOME IMPROVEMENT SERVICES'),
            ActionButton(
              text: 'HOME IMPROVEMENT SERVICES',
              color: successColor,
              onTap: () {
                Get.to(() => const HomeImprovementServicesScreen());
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const ContactUs());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize: Size(Get.width, 50),
              ),
              child: Text(
                'Contact your CM'.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: secondary,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ).paddingSymmetric(horizontal: 24),
    );
  }
}
