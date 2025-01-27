import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/hi_controller.dart';
import 'package:lotuspmc/screen/widget/appbar.dart';
import 'package:lotuspmc/screen/widget/input.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';

class HIOpenRequestScreen extends StatelessWidget {
  const HIOpenRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HIController hiController = Get.find();
    hiController.fetchHIOpen();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nOPEN PROJECTS",
        backgroundColor: highlightColor,
      ),
      body: Obx(() {
        if (hiController.isLoadingOpen.value) {
          return loadingData();
        }
        if (hiController.hiOpenData.value!.data!.piInfos!.isEmpty) {
          return noData();
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Submission Date')),
              DataColumn(label: Text('PI No.')),
              DataColumn(label: Text('PI Description')),
              DataColumn(label: Text('PI Estd. Cost')),
              DataColumn(label: Text('PI Completion Date')),
              DataColumn(label: Text('Action')),
            ],
            rows: hiController.hiOpenData.value!.data!.piInfos!
                .map(
                  (info) => DataRow(cells: [
                    DataCell(Text(formatDateTime(info.createdAt))),
                    DataCell(Text(info.piNo ?? 'N/A')),
                    DataCell(Text(info.piDesc ?? 'N/A')),
                    DataCell(Text('\$${info.estdCost ?? 'N/A'}')),
                    DataCell(Text(formatDateTime(info.completedDate))),
                    DataCell(
                      Row(
                        children: [
                          if (int.parse(info.isOwnerApproval!) == 1 ||
                              int.parse(info.isOwnerApproval!) == 0)
                            TextButton(
                              onPressed: () async {
                                if (int.parse(info.isOwnerApproval!) == 0) {
                                  hiController.hiApproved(info.id);
                                  hiController.fetchHIOpen();
                                }
                              },
                              style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor:
                                      int.parse(info.isOwnerApproval!) == 1
                                          ? Colors.blueGrey
                                          : Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  )),
                              child: Text(
                                hiController.isLoadingApproved.value
                                    ? 'Approving...'
                                    : int.parse(info.isOwnerApproval!) == 1
                                        ? 'Approved'
                                        : 'Approve',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          if (int.parse(info.isOwnerApproval!) == 1 ||
                              int.parse(info.isOwnerApproval!) == 0)
                            const SizedBox(width: 10),
                          if (int.parse(info.isOwnerApproval!) == 0 ||
                              int.parse(info.isOwnerApproval!) == 3)
                            TextButton(
                              onPressed: () {
                                Get.dialog(
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      loadingData(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(6),
                                              ),
                                            ),
                                            child: Material(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    'Reason for Denial (*)',
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SmallInputBox(
                                                    title: 'reason',
                                                    maxLines: 2,
                                                    controller: hiController
                                                        .hidenyController,
                                                    onSubmit: () {},
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                const Color(
                                                              0xFFFFFFFF,
                                                            ),
                                                            backgroundColor:
                                                                Colors.blueGrey,
                                                            minimumSize:
                                                                const Size(
                                                                    0, 45),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            hiController.hiDeny(
                                                                info.id);
                                                            Get.back();
                                                            hiController
                                                                .fetchHIOpen();
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                const Color(
                                                              0xFFFFFFFF,
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                            minimumSize:
                                                                const Size(
                                                                    0, 45),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            'Submit',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ).paddingAll(20),
                                          ).paddingSymmetric(horizontal: 30),
                                        ],
                                      ),
                                      if (hiController.isLoadingDeny.value)
                                        loadingData()
                                    ],
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                'Deny',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ]),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}
