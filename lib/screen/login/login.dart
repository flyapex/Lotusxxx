import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/controller/db_controller.dart';
import 'package:lotuspmc/controller/user_controller.dart';
import 'package:lotuspmc/model/auth/auth_model.dart';
import 'package:lotuspmc/screen/home.dart';
import '../../service/style/color.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());
  DBController dbController = Get.find();

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Get.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  'WELCOME TO',
                  style: TextStyle(
                    fontSize: 18,
                    color: primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  'LOTUS PROPERTY MANAGEMENT COMPANY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: primary,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 40),
                TextFormField(
                  controller: userController.emailController,
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(color: secondary),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primary, width: 2),
                    ),
                    hintText: 'abc@gmail.com',
                    hintStyle: TextStyle(color: secondary),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: userController.passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(color: secondary),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primary, width: 2),
                    ),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: secondary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: primary,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: secondary),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      LoginResponseModel? result =
                          await userController.manualLogin();
                      if (result != null) {
                        dbController.saveUserToken(result.data.token);
                        dbController.saveUserName(
                            '${result.data.fName} ${result.data.lName}');
                        dbController.saveUserID(result.data.id.toString());
                        Get.offAll(() => const HomeScreen());
                      }
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
                    'SIGN IN',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.to(() => const SignUpScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Let’s ',
                        style: TextStyle(color: secondary),
                      ),
                      Text(
                        'Connect.',
                        style: TextStyle(color: primary, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}
