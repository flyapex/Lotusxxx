import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/sr_controller.dart';
import 'package:lotuspmc/screen/widget/appbar.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';

class SROpenRequestScreen extends StatelessWidget {
  const SROpenRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SRController srController = Get.find();
    srController.fetchSROpen();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nOPEN ITEMS",
        backgroundColor: highlightColor,
      ),
      body: Obx(() {
        if (srController.srOpenData.value == null) {
          return loadingData();
        }

        if (srController.srOpenData.value!.data!.srInfos!.isEmpty) {
          return noData();
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text("Submission Date")),
              DataColumn(label: Text("SR Type")),
              DataColumn(label: Text("SR Description")),
              DataColumn(label: Text("Is Area Based Floor Plan")),
              DataColumn(label: Text("Approval Status")),
              DataColumn(label: Text("Repair Date")),
            ],
            rows: srController.srOpenData.value!.data!.srInfos!
                .map(
                  (info) => DataRow(cells: [
                    DataCell(Text(formatDateTime(info.submitDate))),
                    DataCell(Text(info.srType ?? 'N/A')),
                    DataCell(Text(info.lastActionDesc ?? 'N/A')),
                    const DataCell(Text('')),
                    const DataCell(Text('N/A')),
                    const DataCell(Text('N/A')),
                  ]),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}
