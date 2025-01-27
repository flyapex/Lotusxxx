import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/wt_controller.dart';
import 'package:lotuspmc/screen/widget/appbar.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';

class WTOpenRequestScreen extends StatelessWidget {
  const WTOpenRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WTController wtController = Get.find();
    wtController.fetchWtOpen();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nOPEN ITEMS",
        backgroundColor: highlightColor,
      ),
      body: Obx(() {
        if (wtController.isLoading.value) {
          return loadingData();
        }
        if (wtController.wtOpenData.value!.data!.reports!.isEmpty) {
          return noData();
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              //Date	Description	Approval Status	Repair Date
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Description')),
              DataColumn(label: Text('Approval Status')),
              DataColumn(label: Text('Repair Date')),
            ],
            rows: wtController.wtOpenData.value!.data!.reports!
                .map(
                  (info) => DataRow(cells: [
                    DataCell(Text(formatDateTime(info.createdAt))),
                    DataCell(Text(info.lastActionDesc ?? 'N/A')),
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
