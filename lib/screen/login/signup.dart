import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/user_controller.dart';
import 'package:pick_country_picker/pick_country_picker.dart';
import '../../service/style/color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserController userController = Get.find();

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.90,
        child: CountryPickerModal(
          hideCloseIcon: true,
          hideSearch: false,
          backButton: Container(),
          selectedCountryIsoCode: userController.selectedCountry?.iso2Code,
          // excludedCountryCodes: excludedCountryCodes,
          title: 'Select a country',
          priorityCountryCodes: const ['US', 'CA', 'GB', 'LV'],
          onCountryChanged: (Country country) {
            _isCountryValid = true;
            setState(() => userController.selectedCountry = country);
            Navigator.of(context).pop();
          },
          countryDisplayBuilder: (Country country) {
            return country.countryName;
          },
          subtitleBuilder: (Country country) {
            return '+${country.countryCode}';
          },
          flagBuilder: (Country country) {
            return Image.asset(
              country.flagUri!,
              package: 'pick_country_picker',
              width: 32,
              height: 20,
            );
          },
          borderBuilder: Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.grey[400]!,
              width: 0.5,
            )),
          ),
          useCupertinoModal: false, // Set to false to use Material design
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  bool _isLengthOfTermValid = true;

  void _validateLengthOfTerm() {
    setState(() {
      _isLengthOfTermValid =
          userController.selectedLengthOfTerm.value.isNotEmpty;
    });
  }

  bool _isCountryValid = true;
  void _validateCountry() {
    setState(() {
      _isCountryValid = userController.selectedCountry != null;
    });
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: secondary),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator, // Defaults to null if not provided
      maxLines: maxLines,
    ).paddingSymmetric(vertical: 10);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Get.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: secondary),
        centerTitle: true,
        title: Text(
          'Let’s connect',
          style: TextStyle(
            fontSize: 18,
            color: primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'LOTUS',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: secondary,
                        ),
                      ),
                      Text(
                        'PROPERTY MANAGEMENT',
                        style: TextStyle(
                          fontSize: 14,
                          color: secondary,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                buildTextField(
                  label: 'YOUR FIRST NAME',
                  controller: userController.firstNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                buildTextField(
                  label: 'YOUR LAST NAME',
                  controller: userController.lastNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                buildTextField(
                  label: 'EMAIL *',
                  controller: userController.emailController,
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                buildTextField(
                  label: 'Phone',
                  controller: userController.phoneController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const Text(
                  'ADDRESS',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _showCountryPicker,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: _isCountryValid ? primary : Colors.red,
                      ),
                    ),
                    minimumSize: Size(screenWidth, 50),
                  ),
                  child: userController.selectedCountry == null
                      ? Text(
                          'Select a Country',
                          style: TextStyle(
                            color: _isCountryValid ? secondary : Colors.red,
                            fontSize: 16,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              userController.selectedCountry!.countryName,
                              style: TextStyle(color: secondary),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              userController.selectedCountry!.flagUri!,
                              package: 'pick_country_picker',
                              width: 32,
                              height: 20,
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 10),
                if (!_isCountryValid)
                  const Text(
                    'Please select a country',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ).paddingSymmetric(horizontal: 10, vertical: 5),
                buildTextField(
                  label: 'Address Line 1*',
                  controller: userController.addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.streetAddress,
                ),
                buildTextField(
                  label: 'Address Line 2',
                  controller: userController.address1Controller,
                  keyboardType: TextInputType.streetAddress,
                ),
                buildTextField(
                  label: 'CITY',
                  controller: userController.cityController,
                  keyboardType: TextInputType.text,
                ),
                buildTextField(
                  label: 'STATE',
                  controller: userController.stateController,
                  keyboardType: TextInputType.text,
                ),
                buildTextField(
                  label: 'ZIP CODE',
                  controller: userController.zipCodeController,
                  keyboardType: TextInputType.number,
                ),
                buildTextField(
                  label: 'SIZE OF HOME',
                  controller: userController.sizeController,
                  keyboardType: TextInputType.text,
                ),
                // Length of Term Section
                Text(
                  'Length of Term'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    color: _isLengthOfTermValid ? secondary : Colors.red,
                  ),
                ),
                Column(
                  children: [
                    Obx(
                      () => CheckboxListTile(
                        title: const Text('6 Months'),
                        value: userController.selectedLengthOfTerm.value ==
                            '6 months',
                        onChanged: (bool? value) {
                          if (value == true) {
                            userController.selectDuration('6 months');
                          }
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        title: const Text('1 Year'),
                        value: userController.selectedLengthOfTerm.value ==
                            '1 year',
                        onChanged: (bool? value) {
                          if (value == true) {
                            userController.selectDuration('1 year');
                          }
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
                buildTextField(
                  label: 'MESSAGE *',
                  controller: userController.messageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    _validateCountry();
                    _validateLengthOfTerm();
                    if (_formKey.currentState?.validate() ?? false) {
                      userController.manualRegister();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: Size(screenWidth, 50),
                  ),
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ).paddingSymmetric(horizontal: 24),
          ),
        ),
      ),
    );
  }
}
