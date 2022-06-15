import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:instagram_clone_flutter/presentation/screens/login_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram",
      home: LoginScreen(),
    );
  }
}
