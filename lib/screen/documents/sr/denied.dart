import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/sr_controller.dart';
import 'package:lotuspmc/screen/widget/appbar.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';

class SRDeniedRequestScreen extends StatelessWidget {
  const SRDeniedRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SRController srController = Get.put(SRController());
    srController.fetchSRDenied();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nDENIED ITEMS",
        backgroundColor: highlightColor,
      ),
      body: Obx(() {
        if (srController.srDeniedData.value == null) {
          return loadingData();
        } else if (srController.srDeniedData.value!.data!.srInfos!.isEmpty) {
          return noData();
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              //Submission Date	SR Type	SR Description	Is Area Based Floor Plan	Denial Date	Reason for Denial
              DataColumn(label: Text('Submission Date')),
              DataColumn(label: Text('SR Type')),
              DataColumn(label: Text('SR Description')),
              DataColumn(label: Text('Is Area Based Floor Plan')),
              DataColumn(label: Text('Denial Date')),
              DataColumn(label: Text('Reason for Denial')),
            ],
            rows: srController.srDeniedData.value!.data!.srInfos!
                .map(
                  (info) => DataRow(cells: [
                    DataCell(Text(formatDateTime(info.submitDate))),
                    DataCell(Text(info.srType ?? 'N/A')),
                    DataCell(Text(info.lastActionDesc ?? 'N/A')),
                    const DataCell(Text('')),
                    DataCell(Text(formatDateTime(info.denialDate))),
                    DataCell(Text(info.reasonForDenial ?? 'N/A')),
                  ]),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}
