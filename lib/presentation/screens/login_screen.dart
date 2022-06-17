import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/presentation/controllers/auth_controller.dart';

import 'package:instagram_clone_flutter/presentation/screens/register_screen.dart';
import 'package:instagram_clone_flutter/presentation/widgets/custom_button.dart';
import 'package:instagram_clone_flutter/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }
    authController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 200,
              height: 100,
            ),
            const SizedBox(height: 50),
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
                text: "Login",
                onPressed: login,
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
                  'Don\'t have an account?',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => Get.offAllNamed(RegisterScreen.routeName),
                  child: const Text(
                    "Sign Up",
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
    );
  }
}
