import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/wt_controller.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';
import '../../widget/appbar.dart';
import '../../widget/button.dart';

class WalkThruReposts extends StatelessWidget {
  const WalkThruReposts({super.key});

  @override
  Widget build(BuildContext context) {
    WTController wtController = Get.find();

    wtController.fetchWtAll();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nWALK-THRU REPORTS",
        backgroundColor: highlightColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActionButton(
              text: 'All Reports',
              color: lightBackground,
              onTap: () {},
            ).paddingSymmetric(vertical: 20),
            Text(
              'SELECT A DATE BELOW TO REVIEW THE \nCORRESPONDING REPORTS',
              style: TextStyle(color: secondary),
            ).paddingOnly(bottom: 16),
            Obx(() {
              if (wtController.isLoadingAll.value) {
                return loadingData();
              }
              if (wtController.wtAllData.value!.data!.reports!.isEmpty) {
                return noData();
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: wtController.wtAllData.value!.data!.reports!.length,
                itemBuilder: (context, index) {
                  final dates = wtController.wtAllData.value!.data!.reports!;
                  return ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                      formatDateTime(dates[index].createdAt),
                    ),
                    onTap: () {
                      print('Selected: ${dates[index]}');
                      if (dates[index].id != null) {
                        wtController.fetchPDF(
                          dates[index].id!,
                        );
                      } else {
                        // Handle the case where id is null
                        print('Error: Report ID is null');
                      }
                    },
                  );
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
