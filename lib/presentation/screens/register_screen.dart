import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/common/helpers/image_picker_helper.dart';
import 'package:instagram_clone_flutter/presentation/controllers/auth_controller.dart';

import 'package:instagram_clone_flutter/presentation/screens/login_screen.dart';
import 'package:instagram_clone_flutter/presentation/widgets/custom_button.dart';
import 'package:instagram_clone_flutter/presentation/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  File? pickedImage;

  Future<void> pickImage() async {
    final image = await pickImageFromGallery();
    if (image == null) return;
    setState(() {
      pickedImage = image;
    });
  }

  Future<void> register() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty ||
        pickedImage == null) {
      return;
    }
    authController.register(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      profileImageFile: pickedImage!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: pickedImage == null
                            ? Image.asset(
                                'assets/images/user.png',
                                width: 100,
                                height: 100,
                              )
                            : Image.file(
                                pickedImage!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                        ),
                        onPressed: pickImage,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  hintText: 'Name',
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Email',
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 40,
                ),
                Obx(
                  () => CustomButton(
                    text: "Register",
                    onPressed: register,
                    isLoading: authController.loading,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      color: Colors.white,
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => Get.offAllNamed(LoginScreen.routeName),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
