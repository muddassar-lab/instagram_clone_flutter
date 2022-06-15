import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:instagram_clone_flutter/presentation/widgets/custom_button.dart';
import 'package:instagram_clone_flutter/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
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
            CustomButton(
              text: "Login",
              isLoading: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
