import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/sr_controller.dart';
import 'package:lotuspmc/screen/widget/appbar.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';

class SRCompletedRequestScreen extends StatelessWidget {
  const SRCompletedRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SRController srController = Get.find();

    srController.fetchSRCompleted();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nCOMPLETED ITEMS",
        backgroundColor: highlightColor,
      ),
      body: Obx(() {
        if (srController.srCompletedData.value == null) {
          return loadingData();
        }
        if (srController.srCompletedData.value!.data!.srInfos!.isEmpty) {
          return noData();
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Submission Date')),
              DataColumn(label: Text('SR Type')),
              DataColumn(label: Text('SR Description')),
              DataColumn(label: Text('Is Area Based Floor Plan')),
              DataColumn(label: Text('Completed Date')),
              DataColumn(label: Text('Cost of Correction')),
            ],
            rows: srController.srCompletedData.value!.data!.srInfos!
                .map(
                  (info) => DataRow(cells: [
                    DataCell(Text(formatDateTime(info.submitDate))),
                    DataCell(Text(info.srType ?? 'N/A')),
                    DataCell(Text(info.lastActionDesc ?? 'N/A')),
                    const DataCell(Text('')),
                    DataCell(Text(formatDateTime(info.completedDate))),
                    DataCell(Text('\$${info.costOfCorrection ?? 'N/A'}')),
                  ]),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}
