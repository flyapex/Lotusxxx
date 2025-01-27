import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/property_controller.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:lotuspmc/service/style/color.dart';
import 'widget/appbar.dart';
import 'widget/cart.dart';
import 'widget/text.dart';

class PropertyInformationScreen extends StatelessWidget {
  const PropertyInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PropertyController propertyController = Get.find();
    propertyController.fetchPropertyInformation();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(
        title: "\nLOTUS PROPERTY / CLIENT INFORMATION",
        backgroundColor: lightBackground,
      ),
      body: Obx(
        () {
          if (propertyController.isLoading.value) {
            return loadingData();
          }
          final property = propertyController.propertyInfo.value?.data;
          if (property == null) {
            return noData();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleWithBorder(title: 'HOME OVERVIEW'),
                SubTitleWithBorder(
                  title: 'ADDRESS:',
                  subtitle: property.address ?? 'N/A',
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubTitleWithBorder(
                        title: 'SIZE OF HOME:',
                        subtitle: property.sizeOfHome ?? 'N/A',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SubTitleWithBorder(
                        title: 'YEAR BUILT:',
                        subtitle: property.yearBuilt ?? 'N/A',
                      ),
                    ),
                  ],
                ),
                SubTitleWithBorder(
                  title: 'NUMBER OF STORIES:',
                  subtitle: property.numberOfStories ?? 'N/A',
                ),
                SubTitleWithBorder(
                  title: 'CONSTRUCTION TYPE:',
                  subtitle: property.constructionType ?? 'N/A',
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubTitleWithBorder(
                        title: 'IMPACT WINDOWS:',
                        subtitle: property.impactWindows ?? 'N/A',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SubTitleWithBorder(
                        title: 'NUMBER OF STORIES:',
                        subtitle: property.numberOfStories ?? 'N/A',
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubTitleWithBorder(
                        title: 'POOL:',
                        // property.constructionType,
                        subtitle: '${property.hasPool}, ${property.poolType}',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SubTitleWithBorder(
                        title: 'HOA:',
                        subtitle: property.hasHoa ?? 'N/A',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubTitleWithBorder(
                        title: 'GATED COMMUNITY:',
                        subtitle: property.gatedCommunity ?? 'N/A',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SubTitleWithBorder(
                        title: 'GATED PROPERTY:',
                        subtitle: property.gatedProperty ?? 'N/A',
                      ),
                    ),
                  ],
                ),

                const TitleWithBorder(title: 'CONTACT PREFERENCES'),

                SubTitleWithBorder(
                  title: 'NAME:',
                  subtitle: property.contactName ?? 'N/A',
                  padding: 10,
                ),
                SubTitleWithBorder(
                  title: 'EMAIL:',
                  subtitle: property.contactEmail ?? 'N/A',
                  padding: 5,
                ),
                SubTitleWithBorder(
                  title: 'CELL:',
                  subtitle: property.contactCell ?? 'N/A',
                  padding: 5,
                ),
                SubTitleWithBorder(
                  title: 'CLIENT PREFERS TO BE CONTACTED VIA:',
                  subtitle: property.preferredContactMethod ?? 'N/A',
                  padding: 5,
                ),

                const TitleWithBorder(title: 'PROPERTY FLOORPLANS'),
                const SizedBox(height: 20),
                // Floorplans
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  childAspectRatio: 0.9,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    property.floors!.length,
                    (index) {
                      final floor = property.floors![index];
                      return CartContainer(
                        label: floor.floorName ?? 'N/A',
                        image: floor.floorImage ?? 'N/A',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),
                // ElevatedButton(
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(
                //       backgroundColor: lightBackground,
                //       padding: const EdgeInsets.symmetric(
                //           vertical: 12, horizontal: 20),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       textStyle: const TextStyle(
                //           fontSize: 14, fontWeight: FontWeight.w100)),
                //   child: Text(
                //     'CONTACT US FOR UPDATES',
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: secondary,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // const TitleWithBorder(title: 'PROPERTY FLOORPLANS'),
                // Text(
                //   "CLICK ON A FLOORPLAN TO ENLARGE THE VIEW.",
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: secondary.withOpacity(0.5),
                //   ),
                // ),

                const SizedBox(height: 40),
              ],
            ).paddingSymmetric(horizontal: 24),
          );
        },
      ),
    );
  }
}
