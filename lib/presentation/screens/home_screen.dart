import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/presentation/controllers/auth_controller.dart';
import 'package:instagram_clone_flutter/presentation/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  static const String routeName = '/home';
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          onPressed: () => authController.logout(),
          text: "Logout",
        ),
      ),
    );
  }
}
