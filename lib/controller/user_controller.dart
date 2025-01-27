import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/api/api_auth.dart';
import 'package:lotuspmc/model/auth/auth_model.dart';
import 'package:lotuspmc/model/auth/singup.dart';
import 'package:lotuspmc/model/common.dart';
import 'package:lotuspmc/model/contact%20us/pm_info.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:pick_country_picker/pick_country_picker.dart';

class UserController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<LoginResponseModel?> manualLogin() async {
    try {
      LoginResponseModel? response = await ApiServiceLogin.manualLoginApi(
        LoginModel(
          email: emailController.text,
          password: passwordController.text,
        ),
      );

      if (response != null) {
        showSnackbar(
          'Success',
          response.message.toString(),
        );
        return response;
      } else {
        showSnackbar(
          'Error',
          "Email Address or Password is incorrect!",
        );
        return null;
      }
    } catch (e) {
      print('Error in manualLogin: $e');
      showSnackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
      );
      return null;
    }
  }

  var selectedLengthOfTerm = ''.obs;

  void selectDuration(String duration) {
    selectedLengthOfTerm.value = duration;
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Country? selectedCountry;

  void manualRegister() async {
    try {
      ResponseModel? response = await ApiServiceLogin.manualRegisterApi(
        SingUpModel(
          fName: firstNameController.text,
          lName: lastNameController.text,
          email: emailController.text,
          phone: phoneController.text,
          address: addressController.text,
          addressLine1: address1Controller.text,
          city: cityController.text,
          state: stateController.text,
          zipCode: zipCodeController.text,
          sizeOfHome: sizeController.text,
          message: messageController.text,
          lengthOfTerm: selectedLengthOfTerm.value,
          country: selectedCountry?.countryName,
        ),
      );
      print(response);
      if (response != null) {
        showSnackbar("Success", response.message);
        await Future.delayed(const Duration(seconds: 2));
        Get.back(closeOverlays: true);
      } else {
        showSnackbar(
          'Error',
          "The email or phone number has already been taken.",
        );
        return null;
      }
    } catch (e) {
      print('Error in manualLogin: $e');
      showSnackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
      );
      return null;
    }
  }

  //getPMInfoApi
  var pmData = Rxn<PminfoModel>();
  var isLoadingPM = false.obs;

  void fatchPminfo() async {
    try {
      isLoadingPM.value = true;
      var response = await ApiServiceLogin.getPMInfoApi();
      if (response != null) {
        pmData.value = response;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingPM.value = false;
    }
  }
}
