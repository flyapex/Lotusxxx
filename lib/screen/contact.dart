import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/user_controller.dart';
import 'package:lotuspmc/screen/widget/appbar.dart';
import 'package:lotuspmc/service/style/color.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    userController.fatchPminfo();
    String abbreviateName(String fullName) {
      List<String> nameParts = fullName.split(" ");
      return nameParts.map((part) => part[0].toUpperCase()).join();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyappBar(title: "Contact Us", backgroundColor: primary),
      body: Center(child: Obx(() {
        if (userController.isLoadingPM.value) {
          return const CircularProgressIndicator();
        }
        if (userController.pmData.value == null) {
          return const Text('No Data Found');
        }
        return Container(
          padding: const EdgeInsets.all(16.0),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 40,
                    // backgroundImage: const AssetImage('assets/profile.jpg'),
                    child: Center(
                      child: Text(
                        abbreviateName(
                            userController.pmData.value!.pmName ?? 'No Name'),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                userController.pmData.value!.pmName ?? 'No Name',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Client Manager",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "john.doe@lotus.com",
                          style: TextStyle(
                            color: secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text("Email"),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "+88016428484",
                          style: TextStyle(
                            color: secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text("  Call "),
                  ),
                  // +88016428484 number
                ],
              )
            ],
          ),
        );
      })),
    );
  }
}
