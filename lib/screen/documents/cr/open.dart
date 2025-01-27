import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/cr_controller.dart';
import 'package:lotuspmc/screen/widget/appbar.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';

class CROpenRequestScreen extends StatelessWidget {
  const CROpenRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CRController crController = Get.find();
    crController.fetchCROpen();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nOPEN ITEMS",
        backgroundColor: highlightColor,
      ),
      body: Obx(() {
        if (crController.crOpenData.value == null) {
          return loadingData();
        }
        if (crController.crOpenData.value!.data!.crInfos!.isEmpty) {
          return noData();
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text("Submission Date")),
              DataColumn(label: Text("CR Description")),
              DataColumn(label: Text("Approval Status")),
              DataColumn(label: Text("Repair Date")),
            ],
            rows: crController.crOpenData.value!.data!.crInfos!
                .map(
                  (info) => DataRow(cells: [
                    DataCell(Text(formatDateTime(info.submitDate))),
                    DataCell(Text(info.description ?? 'N/A')),
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
