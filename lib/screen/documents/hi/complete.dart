import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/hi_controller.dart';
import 'package:lotuspmc/screen/widget/appbar.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';

class HiCompleteProjectScreen extends StatelessWidget {
  const HiCompleteProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HIController hiController = Get.find();
    hiController.fetchHICompleteProject();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nCOMPLETED ITEMS",
        backgroundColor: highlightColor,
      ),
      body: Obx(() {
        if (hiController.hiCompleteProjectData.value == null) {
          return loadingData();
        }
        if (hiController.hiCompleteProjectData.value!.data!.piInfos!.isEmpty) {
          return noData();
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Submission Date')),
              DataColumn(label: Text('PI No.')),
              DataColumn(label: Text('PI Description')),
              DataColumn(label: Text('PI Actual Cost')),
              DataColumn(label: Text('PI Completion Date')),
            ],
            rows: hiController.hiCompleteProjectData.value!.data!.piInfos!
                .map(
                  (info) => DataRow(cells: [
                    DataCell(Text(formatDateTime(info.createdAt))),
                    DataCell(Text(info.piNo ?? 'N/A')),
                    DataCell(Text(info.piDesc ?? 'N/A')),
                    DataCell(Text('\$${info.actualCost ?? 'N/A'}')),
                    DataCell(Text(formatDateTime(info.completedDate))),
                  ]),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}
