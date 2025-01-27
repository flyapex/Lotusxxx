import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/cr_controller.dart';
import 'package:lotuspmc/screen/widget/appbar.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';

class CRCompletedRequestScreen extends StatelessWidget {
  const CRCompletedRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CRController crController = Get.put(CRController());
    crController.fetchCRCompleted();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nCOMPLETED ITEMS",
        backgroundColor: highlightColor,
      ),
      body: Obx(() {
        if (crController.crCompletedData.value == null) {
          return loadingData();
        }
        if (crController.crCompletedData.value!.data!.crInfos!.isEmpty) {
          return noData();
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              //  Submission Date	CR Description	Completed Date	Cost of Correction
              DataColumn(label: Text('Submission Date')),
              DataColumn(label: Text('CR Description')),
              DataColumn(label: Text('Completed Date')),
              DataColumn(label: Text('Cost of Correction')),
            ],
            rows: crController.crCompletedData.value!.data!.crInfos!
                .map(
                  (info) => DataRow(cells: [
                    DataCell(Text(formatDateTime(info.submitDate))),
                    DataCell(Text(info.description ?? 'N/A')),
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
